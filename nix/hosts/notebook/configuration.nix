{
  ...
}:

{
  imports = [
    # Include home-manager configuration and other modular settings
    <home-manager/nixos>
    ./packages.nix
    ./services/audio.nix
    ./services/docker.nix
    ./services/ssh.nix
    ./services/power.nix
    ./services/sync.nix
    ./sys/fonts.nix
    ./sys/graphics.nix
    ./sys/input.nix
    ./services/server.nix
    ./services/wireguard.nix
    ./users/char.nix
    /etc/nixos/hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes"];
  # Bootloader Configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking Configuration
  networking.hostName = "mbp"; # Define your hostname
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [
    7070
    8096
    8080
    4443
    8112
    11434 ## ollama
    4040 ## openwebui
    9998 ## tika
  ];
  networking.firewall = {
    allowedUDPPorts = [ 51820 ];
  };

  # Time Zone Configuration
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";

  # System State Version
  system.stateVersion = "24.11"; # Did you read the comment?

  # Allow Unfree Packages (like Spotify, Steam)
  nixpkgs.config.allowUnfree = true;

  #https://askubuntu.com/questions/1434722/macbook-takes-20-seconds-to-wake-up
  # only for macbook
  boot.kernelParams = [ "mem_sleep_default=s2idle" ];
}
