{ pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    # settings.gui = {
    #   user = "myuser";
    #   password = "mypassword";
    # };
    # or the password hash can be generated with "syncthing generate --config <path> --gui-password=<password>"
    settings = {
      devices = {
        "mbp" = {
          id = "DL5OTVT-CL7TM6G-4DZ3OH7-BSWARFK-ZN5POZG-ZOQSYAG-HEW5ERH-2ZQFEQG";
        };
        "sff" = {
          id = "DEVICE-ID-GOES-HERE";
        };
      };
      folders = {
        "Documents" = {
          path = "/home/char/docs";
          devices = [
            "mbp"
            "sff"
          ];
        };
      };
    };
  };
  # Don't create default ~/Sync folder
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
}
