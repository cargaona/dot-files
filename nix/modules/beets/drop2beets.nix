{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Path where TLMSC bot downloads albums
  watchDir = "/mnt/nvme/tlmsc/staging/";

  # Path to your beets music library
  musicLibrary = "/mnt/seagate/music/";

  # Beets config location
  beetsConfig = "/home/char/.config/beets/config.yaml";

  # Script that watches for new folders and imports them
  drop2beetsScript = pkgs.writeShellScript "drop2beets" ''
    #!/usr/bin/env bash
    set -euo pipefail

    WATCH_DIR="${watchDir}"
    BEETS_CONFIG="${beetsConfig}"

    echo "drop2beets: Watching $WATCH_DIR for new albums..."

    ${pkgs.inotify-tools}/bin/inotifywait -m -e create -e moved_to --format '%w%f' "$WATCH_DIR" | while read -r path; do
      if [[ -d "$path" ]]; then
        echo "drop2beets: New folder detected: $path"
        sleep 5  # Wait for download to fully complete
        
        echo "drop2beets: Importing $path"
        ${pkgs.beets}/bin/beet -c "$BEETS_CONFIG" import -q "$path"
        
        if [[ $? -eq 0 ]]; then
          echo "drop2beets: Successfully imported $path"
          rm -rf "$path"
        else
          echo "drop2beets: Failed to import $path"
        fi
      fi
    done
  '';
in
{
  systemd.services.drop2beets = {
    description = "Watch staging folder and import to beets";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${drop2beetsScript}";
      Restart = "always";
      RestartSec = 10;

      # Run as your user (adjust as needed)
      User = "char";
      Group = "users";

      # Hardening
      ProtectSystem = "strict";
      ProtectHome = "read-only";
      ReadWritePaths = [
        watchDir
        musicLibrary
      ];
      PrivateTmp = true;
    };
  };

  # Ensure directories exist
  systemd.tmpfiles.rules = [
    "d ${watchDir} 0755 char users -"
  ];
}
