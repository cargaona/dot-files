{
  caelestia-shell,
  ambxst,
  ...
}:

{
  imports = [
    # Minimal configuration for initial boot and SSH access
    ../../modules/system/host-options.nix
    ../../packages/common.nix
    ../../packages/llm.nix
    ../../modules/network/ssh.nix
    ../../users/char.nix
    /etc/nixos/hardware-configuration.nix

    # Desktop environment modules - uncomment when ready
    ../../modules/desktop/fonts.nix
    # ../../modules/desktop/cosmic.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/input.nix

    # Hardware modules - uncomment when ready
    ../../modules/hardware/audio.nix
    ../../modules/hardware/nvidia.nix
    ../../modules/hardware/power.nix
    ../../modules/hardware/kindle.nix

    # Service modules - uncomment when ready
    # ../../modules/llm/ollama.nix
    # Firefox bookmark/history/extension sync via rsync over SSH (hub: kramer)
    # Pushes profile every 15min, pulls every 1h. See modules/network/sync.nix for details.
    # To enable: uncomment the line below and rebuild both desktops + kramer.
    # ../../modules/network/sync.nix
    ../../modules/virtualization/docker.nix
    # ../../modules/dev/android.nix
    ambxst.nixosModules.default
  ];

  # Host-specific configuration
  host.isDesktop = true;

  # LLM configuration - uncomment when ready
  # services.llm.ollama = {
  #   enable = true;
  #   acceleration = "cuda";
  #   host = "0.0.0.0";
  #   port = 11434;
  #   gpuOverhead = "1000000000";
  # };

  home-manager.extraSpecialArgs = {
    inherit caelestia-shell;
    isDesktop = true;
  };

  home-manager.users.char =
    {
      pkgs,
      lib,
      caelestia-shell,
      ...
    }:
    {
      imports = [
        caelestia-shell.homeManagerModules.default
        ../../home/home.nix
      ];
    };

  # Nix configuration
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 7d";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader Configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking Configuration
  networking.hostName = "elaine";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [
    # Add ports as needed
  ];
  networking.firewall.allowedUDPPorts = [
    # Add ports as needed
  ];

  # Time Zone Configuration
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";

  # System State Version
  system.stateVersion = "25.11";

  # Allow Unfree Packages
  nixpkgs.config.allowUnfree = true;
}
