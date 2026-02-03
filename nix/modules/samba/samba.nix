{ config, pkgs, ... }:

{
  # Enable Samba service
  services.samba = {
    enable = true;
    openFirewall = true;

    # In modern NixOS, EVERYTHING goes inside 'settings'
    # 'global' is for server-wide flags, then each share is its own block
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "PS2-NixOS-Server";
        "netbios name" = "smbnix";

        # Mandatory for OPL (SMBv1/NT1)
        "server min protocol" = "NT1";
        "lanman auth" = "yes";
        "ntlm auth" = "yes";

        # Security & Stability tweaks for PS2
        "server signing" = "disabled";
        "smb encrypt" = "disabled";
      };

      "PS2SMB" = {
        "path" = "/mnt/nvme/PS2SMB";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "force user" = "char";
        "create mask" = "0775";
        "directory mask" = "0775";
      };
    };
  };

  # Ensure the folder exists with correct permissions
  systemd.tmpfiles.rules = [
    "d /mnt/nvme/PS2SMB 0777 char users -"
  ];
}
