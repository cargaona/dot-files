{
  ...
}:

{
  imports = [
    # Include home-manager configuration and other modular settings
    <home-manager/nixos>
    ../../packages/common.nix
    ../../modules/hardware/audio.nix
    ../../modules/virtualization/docker.nix
    ../../modules/hardware/power.nix
    ../../modules/virtualization/server.nix
    ../../modules/network/ssh.nix
    ../../modules/network/sync.nix
    ../../modules/desktop/fonts.nix
    ../../modules/hardware/nvidia.nix
    ../../modules/desktop/input.nix
    ../../users/char.nix
    /etc/nixos/hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # programs.lxqt-policykit.enable = true;  # Not available in NixOS 25.05
  # programs.polkit-kde-agent.enable = true;
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
  system.stateVersion = "25.05"; # Did you read the comment?

  # Allow Unfree Packages (like Spotify, Steam)
  nixpkgs.config.allowUnfree = true;
}
