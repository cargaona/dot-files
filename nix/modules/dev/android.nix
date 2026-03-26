{ pkgs, ... }:
{
  boot.kernelModules = [
    "kvm-amd"
    "libvirtd"
  ];
  programs.adb.enable = true;
  virtualisation.libvirtd.enable = true;
  # services.udev.packages = [ pkgs.android-udev-rules ];
}
