{ pkgs, ... }:
{
  boot.kernelModules = [ "kvm-amd" ];
  programs.adb.enable = true;
  services.udev.packages = [ pkgs.android-udev-rules ];
}
