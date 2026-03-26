{
  config,
  pkgs,
  ...
}:
{
  # Pin kernel to 6.12 LTS to avoid NVIDIA driver build failures on kernel updates
  boot.kernelPackages = pkgs.linuxPackages_6_12;

  # Nvidia
  hardware.nvidia.open = true; # Recommended for Ampere (RTX 30) and newer since driver 515+
  hardware.nvidia.nvidiaSettings = true;
  hardware.nvidia.modesetting.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ]; # This also enables it for wayland
  hardware.nvidia.powerManagement.enable = true;
  hardware.nvidia.powerManagement.finegrained = false;
  #  services.xserver.displayManager.startx.enable = true; # No display manager
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    version = "580.126.18";
    sha256_64bit = "sha256-p3gbLhwtZcZYCRTHbnntRU0ClF34RxHAMwcKCSqatJ0=";
    openSha256 = "sha256-1Q2wuDdZ6KiA/2L3IDN4WXF8t63V/4+JfrFeADI1Cjg=";
    settingsSha256 = "sha256-QMx4rUPEGp/8Mc+Bd8UmIet/Qr0GY8bnT/oDN8GAoEI=";
    usePersistenced = false;
  };

  boot.kernelModules = [ "v4l2loopback" ];
  # Kernel Packages
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  security.polkit.enable = true;
}
