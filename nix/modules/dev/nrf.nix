{ pkgs, ... }:
{
  nixpkgs.config.segger-jlink.acceptLicense = true;

  nixpkgs.config.permittedInsecurePackages = [
    "segger-jlink-qt4-874"
  ];

  services.udev.packages = [ pkgs.segger-jlink ];
}
