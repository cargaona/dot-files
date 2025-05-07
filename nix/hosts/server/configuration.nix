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
    ../../services/power.nix
    ../../services/server.nix
    ../../services/ssh.nix
    ../../services/sync.nix
    # ../../services/wireguard.nix
    ../../sys/fonts.nix
    ../../sys/nvidia.nix
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

  # Networking Configuration
  networking.hostName = "elaine"; # Define your hostname
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [
    11434 # # ollama
    4040 # # openwebui
    4443
    7070
    8080
    8096
    8112
    9998 # # tika
  ];

  # Time Zone Configuration
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";

  # System State Version
  system.stateVersion = "24.11"; # Did you read the comment?

  # Allow Unfree Packages (like Spotify, Steam)
  nixpkgs.config.allowUnfree = true;
}
