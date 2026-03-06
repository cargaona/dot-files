# Firefox Profile Sync — rsync over SSH
#
# Syncs bookmarks, history, extensions, and extension-data between desktops
# using kramer as a central hub. Each desktop pushes its own profile to
# kramer:/backup/firefox/<hostname>/ and pulls from all other host dirs.
#
# Conflict resolution: --update flag (newest file wins, per-file not per-row).
# Note: places.sqlite is copied wholesale — history is NOT merged across machines,
# whichever file is newest at sync time wins.
#
# Timers:
#   firefox-sync-push  — 5min after boot, then every 15min
#   firefox-sync-pull  — 2min after boot, then every 1h
#
# Files synced:
#   places.sqlite + WAL    (bookmarks + history)
#   favicons.sqlite + WAL  (bookmark favicons)
#   extensions.json        (installed extension list)
#   extension-settings.json
#   extension-data/        (extension storage, e.g. uBlock filter lists)
#
# HOW TO ENABLE:
#   1. Deploy kramer first — systemd.tmpfiles creates /backup/firefox/{constanza,elaine}/
#   2. Uncomment the sync.nix import in:
#        hosts/constanza/configuration.nix
#        hosts/elaine/configuration.nix
#   3. Rebuild both desktops: sudo nixos-rebuild switch
#   4. (First time) Copy your existing places.sqlite into one desktop's Firefox
#      profile, then manually trigger a push:
#        systemctl --user start firefox-sync-push
#   5. On the other desktop, trigger a pull:
#        systemctl --user start firefox-sync-pull
#
# MANUAL COMMANDS:
#   systemctl --user start  firefox-sync-push   # push now
#   systemctl --user start  firefox-sync-pull   # pull now
#   systemctl --user status firefox-sync-push   # last run status
#   journalctl --user -u firefox-sync-push      # logs
{
  config,
  pkgs,
  lib,
  ...
}:

let
  user = "char";
  hub = "kramer";
  hubPath = "/backup/firefox";
  hostname = config.networking.hostName;

  # Files to sync from the Firefox profile
  syncFiles = [
    "places.sqlite"
    "places.sqlite-wal"
    "places.sqlite-shm"
    "favicons.sqlite"
    "favicons.sqlite-wal"
    "favicons.sqlite-shm"
    "extensions.json"
    "extension-settings.json"
  ];

  # Directories to sync from the Firefox profile
  syncDirs = [
    "extension-data"
  ];

  # Build rsync --include flags for our file list
  rsyncIncludes =
    (map (f: "--include='${f}'") syncFiles) ++ (map (d: "--include='${d}/***'") syncDirs);

  rsyncIncludesStr = lib.concatStringsSep " " rsyncIncludes;

  # Script: find the active Firefox profile dir
  # Reads profiles.ini and returns the path of the most recently used profile
  findProfileScript = pkgs.writeShellScript "firefox-find-profile" ''
    set -euo pipefail
    PROFILES_DIR="$HOME/.mozilla/firefox"
    INI="$PROFILES_DIR/profiles.ini"

    if [ ! -f "$INI" ]; then
      echo "No Firefox profiles.ini found at $INI" >&2
      exit 1
    fi

    # Find profile path: prefer Default=1, fallback to first Path= entry
    profile=$(${pkgs.gawk}/bin/awk '
      /^\[Profile/ { in_profile=1; path=""; is_default=0; is_relative=1 }
      in_profile && /^Path=/ { path=substr($0, index($0,"=")+1) }
      in_profile && /^Default=1/ { is_default=1 }
      in_profile && /^IsRelative=0/ { is_relative=0 }
      in_profile && /^$/ {
        if (is_default && path != "") {
          if (is_relative) print ENVIRON["HOME"] "/.mozilla/firefox/" path
          else print path
          exit
        }
        in_profile=0
      }
      END {
        # If no Default=1 found, print the last seen path
        if (path != "") {
          if (is_relative) print ENVIRON["HOME"] "/.mozilla/firefox/" path
          else print path
        }
      }
    ' "$INI")

    if [ -z "$profile" ]; then
      echo "Could not determine Firefox profile path" >&2
      exit 1
    fi

    echo "$profile"
  '';

  # Push script: local profile → kramer hub
  pushScript = pkgs.writeShellScript "firefox-sync-push" ''
    set -euo pipefail

    PROFILE=$(${findProfileScript})
    DEST="${user}@${hub}:${hubPath}/${hostname}/"

    echo "firefox-sync: pushing profile from $PROFILE to $DEST"

    # Ensure destination directory exists on hub
    ${pkgs.openssh}/bin/ssh -o StrictHostKeyChecking=accept-new \
      ${user}@${hub} "mkdir -p ${hubPath}/${hostname}"

    # Rsync selected files only, skip older files on destination (--update)
    ${pkgs.rsync}/bin/rsync \
      --archive \
      --update \
      --compress \
      -e "${pkgs.openssh}/bin/ssh -o StrictHostKeyChecking=accept-new" \
      ${rsyncIncludesStr} \
      --exclude='*' \
      "$PROFILE/" \
      "$DEST"

    echo "firefox-sync: push complete"
  '';

  # Pull script: kramer hub → local profile (for all OTHER hosts)
  pullScript = pkgs.writeShellScript "firefox-sync-pull" ''
    set -euo pipefail

    PROFILE=$(${findProfileScript})

    echo "firefox-sync: pulling data from ${hub} into $PROFILE"

    # For each remote host dir on the hub (excluding our own), pull newer files
    for remote_host in $(${pkgs.openssh}/bin/ssh \
        -o StrictHostKeyChecking=accept-new \
        -o BatchMode=yes \
        ${user}@${hub} "ls ${hubPath}/ 2>/dev/null || true"); do

      if [ "$remote_host" = "${hostname}" ]; then
        continue
      fi

      SRC="${user}@${hub}:${hubPath}/$remote_host/"
      echo "firefox-sync: merging from $remote_host"

      ${pkgs.rsync}/bin/rsync \
        --archive \
        --update \
        --compress \
        -e "${pkgs.openssh}/bin/ssh -o StrictHostKeyChecking=accept-new" \
        ${rsyncIncludesStr} \
        --exclude='*' \
        "$SRC" \
        "$PROFILE/"
    done

    echo "firefox-sync: pull complete"
  '';

in
{
  systemd.user.services.firefox-sync-push = {
    description = "Push Firefox profile to sync hub (kramer)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      # Signal Firefox to close so it flushes WAL, then wait briefly
      ExecStartPre = [
        "${pkgs.procps}/bin/pkill -SIGTERM firefox || true"
        "${pkgs.coreutils}/bin/sleep 2"
      ];
      ExecStart = "${pushScript}";
      # Don't fail the timer if we're offline
      SuccessExitStatus = "0 1 255";
    };
  };

  systemd.user.services.firefox-sync-pull = {
    description = "Pull Firefox profile from sync hub (kramer)";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pullScript}";
      SuccessExitStatus = "0 1 255";
    };
  };

  # Push every 15 minutes
  systemd.user.timers.firefox-sync-push = {
    description = "Periodically push Firefox profile to hub";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5min";
      OnUnitActiveSec = "15min";
      Persistent = true;
    };
  };

  # Pull on login (5 min after boot, then every hour to catch updates from other machine)
  systemd.user.timers.firefox-sync-pull = {
    description = "Periodically pull Firefox profile from hub";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "2min";
      OnUnitActiveSec = "1h";
      Persistent = true;
    };
  };
}
