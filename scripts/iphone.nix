## required to mount iphone device as a filesystem
{ config, pkgs, ... }:
{
  # Ensure the necessary packages are installed
  environment.systemPackages = with pkgs; [
    libimobiledevice
    ifuse
    gvfs
    gvfs-afc
  ];
}
