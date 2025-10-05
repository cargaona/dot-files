{
  # config,
  ...
}:

{
  imports = [
    # Include home-manager configuration and other modular settings
    # <home-manager/nixos>
    ../../packages/common.nix
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/cosmic.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/input.nix
    ../../modules/hardware/audio.nix
    ../../modules/hardware/kindle.nix
    ../../modules/hardware/nvidia.nix
    ../../modules/hardware/power.nix
    ../../modules/network/ssh.nix
    ../../modules/network/sync.nix
    ../../modules/virtualization/docker.nix
    ../../users/char.nix
    /etc/nixos/hardware-configuration.nix
  ];

  home-manager.users.char = import ../../home/home.nix;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Bootloader Configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hardware-specific configurations
  hardware.kindle = {
    enable = true;
    uuid = "9FC0-AE2B";  # Kindle UUID detected from lsblk
    mountPoint = "/home/char/kindle";
    user = "char";
    group = "users";
  };

  # avoid pci devices to wake up computer from suspend
  # https://nixos.wiki/wiki/Power_Management
  # https://wiki.archlinux.org/title/Power_management/Wakeup_triggers#Gigabyte_motherboards
  services.udev.extraRules = ''
    ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x1483" ATTR{power/wakeup}="disabled"
  '';

  # Networking Configuration
  networking.hostName = "sff"; # Define your hostname
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [
    8112
    1234
    8080
    7070 # yarr development from vpn
    8443
  ];
  # Time Zone Configuration
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";

  environment.extraInit = ''
    export PATH=$PATH:/home/char/projects/personal/code/dot-files/scripts/;
  '';

  # System State Version
  system.stateVersion = "25.05"; # Did you read the comment?

  # Allow Unfree Packages (like Spotify, Steam)
  nixpkgs.config.allowUnfree = true;
}
