{
  config,
  ...
}:
{
  # Nvidia
  hardware.nvidia.open = false;
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ]; # This also enables it for wayland
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.powerManagement.finegrained = false;
  #  services.xserver.displayManager.startx.enable = true; # No display manager
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
  #   version = "555.58.02";
  #   sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
  #   sha256_aarch64 = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
  #   openSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
  #   settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
  #   persistencedSha256 = lib.fakeSha256;
  # };

  boot.kernelModules = [ "v4l2loopback" ];
  # Kernel Packages
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  security.polkit.enable = true;
}
