{
  ...
}:

{
  imports = [
    # Include home-manager configuration and other modular settings
    <home-manager/nixos>
    ../../packages.nix
    ../../services/audio.nix
    ../../services/docker.nix
    ../../services/ssh.nix
    ../../services/power.nix
    ../../services/sync.nix
    ../../sys/fonts.nix
    ../../sys/nvidia.nix
    ../../sys/hyprland.nix
    ../../sys/input.nix
    ../../users/char.nix
    /etc/nixos/hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Bootloader Configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # avoid pci devices to wake up computer from suspend
  # https://nixos.wiki/wiki/Power_Management
  # https://wiki.archlinux.org/title/Power_management/Wakeup_triggers#Gigabyte_motherboards
  services.udev.extraRules = ''
    ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x1483" ATTR{power/wakeup}="disabled"
  '';

  # Networking Configuration
  networking.hostName = "sff"; # Define your hostname
  networking.networkmanager.enable = true;

  # Time Zone Configuration
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";

  # System State Version
  system.stateVersion = "25.05"; # Did you read the comment?

  # Allow Unfree Packages (like Spotify, Steam)
  nixpkgs.config.allowUnfree = true;
}
