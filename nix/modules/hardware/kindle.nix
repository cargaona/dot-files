{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.hardware.kindle;
in
{
  options.hardware.kindle = {
    enable = mkEnableOption "Kindle automounting";

    uuid = mkOption {
      type = types.str;
      description = "UUID of the Kindle device";
      example = "9FC0-AE2B";
    };

    mountPoint = mkOption {
      type = types.str;
      default = "/home/char/kindle";
      description = "Mount point for the Kindle";
    };

    user = mkOption {
      type = types.str;
      default = "char";
      description = "User to own the mount point";
    };

    group = mkOption {
      type = types.str;
      default = "users";
      description = "Group to own the mount point";
    };
  };

  config = mkIf cfg.enable {
    # Udev rules to handle directory creation/removal and mounting
    services.udev.extraRules = ''
      # Kindle device detection and mount
      ACTION=="add", SUBSYSTEM=="block", ATTR{uuid}=="${cfg.uuid}", RUN+="${pkgs.bash}/bin/bash -c 'mkdir -p ${cfg.mountPoint} && chown ${cfg.user}:${cfg.group} ${cfg.mountPoint} && ${pkgs.systemd}/bin/systemd-mount --no-block --automount=yes --collect %k ${cfg.mountPoint}'"

      # Kindle device removal and cleanup
      ACTION=="remove", SUBSYSTEM=="block", ATTR{uuid}=="${cfg.uuid}", RUN+="${pkgs.bash}/bin/bash -c 'if mountpoint -q ${cfg.mountPoint}; then ${pkgs.systemd}/bin/systemd-mount --umount ${cfg.mountPoint}; fi && rmdir ${cfg.mountPoint} 2>/dev/null || true'"
    '';

    # Systemd automount service for better integration
    systemd.automounts = [{
      name = "kindle";
      where = cfg.mountPoint;
      automountConfig = {
        TimeoutIdleSec = "30s";  # Unmount after 30s of inactivity
      };
    }];

    # Systemd mount unit
    systemd.mounts = [{
      name = "kindle";
      what = "/dev/disk/by-uuid/${cfg.uuid}";
      where = cfg.mountPoint;
      type = "vfat";
      options = "uid=${cfg.user},gid=${cfg.group},dmask=022,fmask=133,noauto";
      mountConfig = {
        TimeoutSec = "10s";
      };
    }];
  };
}
