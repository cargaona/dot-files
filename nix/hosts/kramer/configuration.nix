{
  ...
}:

{
  imports = [
    # Include home-manager configuration and other modular settings
    # <home-manager/nixos>
    ../../modules/system/host-options.nix
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/input.nix
    ../../modules/hardware/audio.nix
    ../../modules/hardware/nvidia.nix
    ../../modules/hardware/power.nix
    ../../modules/kubernetes/k3s.nix
    ../../modules/immich/immich.nix
    ../../modules/network/ssh.nix
    # ../../modules/llm/ollama.nix
    ../../modules/virtualization/docker.nix
    ../../modules/virtualization/server.nix
    ../../packages/common.nix
    ../../users/char.nix
    /etc/nixos/hardware-configuration.nix
  ];

  # Host-specific configuration
  host.isDesktop = false;

  home-manager.users.char =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports = [
        ../../home/home.nix
      ];
    };

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 7d";
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # programs.lxqt-policykit.enable = true;  # Not available in NixOS 25.05
  # programs.polkit-kde-agent.enable = true;
  # Bootloader Configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking Configuration
  networking.hostName = "kramer"; # Define your hostname
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [
    11434 # # ollama
    2283 # immich
    4040 # # openwebui
    4443
    6767 # bazarr
    7070
    8080
    8096
    8888
    8112
    9998 # # tika
  ];

  networking.firewall.allowedUDPPorts = [
    1244
    1245
    1246
    1247
  ];

  # Firefox sync hub storage directories.
  # kramer acts as the central hub for Firefox profile sync between constanza and elaine.
  # Desktops push to /backup/firefox/<hostname>/ and pull from each other's dirs.
  # See modules/network/sync.nix for the full setup and how to enable it on desktops.
  systemd.tmpfiles.rules = [
    "d /backup/firefox            0755 char users -"
    "d /backup/firefox/constanza  0755 char users -"
    "d /backup/firefox/elaine     0755 char users -"
  ];

  # Time Zone Configuration
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";

  # System State Version
  system.stateVersion = "25.11"; # Did you read the comment?

  # Allow Unfree Packages (like Spotify, Steam)
  nixpkgs.config.allowUnfree = true;
}
