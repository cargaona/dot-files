{
  # config,
  caelestia-shell,
  ambxst,
  ...
}:

{
  imports = [
    # Include home-manager configuration and other modular settings
    # <home-manager/nixos>
    ../../modules/system/host-options.nix
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
    ../../modules/dev/android.nix
    # ../../modules/dev/nrf.nix
    # Firefox bookmark/history/extension sync via rsync over SSH (hub: kramer)
    # Pushes profile every 15min, pulls every 1h. See modules/network/sync.nix for details.
    # To enable: uncomment the line below and rebuild both desktops + kramer.
    # ../../modules/network/sync.nix
    ../../modules/virtualization/docker.nix
    ../../modules/llm/ollama.nix
    ambxst.nixosModules.default
    ../../users/char.nix
    /etc/nixos/hardware-configuration.nix
  ];

  # Host-specific configuration
  host.isDesktop = true;

  # LLM configuration
  services.llm.ollama = {
    enable = true;
    acceleration = "cuda";
    host = "0.0.0.0";
    port = 11434;
    gpuOverhead = "1000000000"; # Reserve ~1GB for other services
  };

  home-manager.extraSpecialArgs = {
    inherit caelestia-shell;
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

  # Hardware-specific configurations
  hardware.kindle = {
    enable = true;
    uuid = "9FC0-AE2B"; # Kindle UUID detected from lsblk
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
  networking.hostName = "costanza"; # Define your hostname
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [
    8112
    1234
    8080
    7070 # yarr development from vpn
    8443
    24800 # deskflow
    11434
  ];
  networking.firewall.allowedUDPPorts = [
    2666 # add this for sensor fusion
    1244
    1245
    24800 # deskflow
  ];

  # Time Zone Configuration
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";

  environment.extraInit = ''
    export PATH=$PATH:/home/char/projects/personal/code/dot-files/scripts/;
  '';

  # System State Version
  system.stateVersion = "25.11"; # Did you read the comment?

  # Allow Unfree Packages (like Spotify, Steam)
  nixpkgs.config.allowUnfree = true;

  # Allow insecure packages (Qt5 WebEngine for telegram-desktop/rockbox-utility)
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];
}
