{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include home-manager configuration and other modular settings
      <home-manager/nixos>
      #./sys/gtk.nix 
      ./packages.nix
      ./services/audio.nix
      ./services/docker.nix
      ./services/ssh.nix
      ./sys/fonts.nix
      ./sys/graphics.nix
      ./users/char.nix
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader Configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking Configuration
  networking.hostName = "sff";  # Define your hostname
  networking.networkmanager.enable = true;

  # Time Zone Configuration
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Internationalization
  i18n.defaultLocale = "en_US.UTF-8";

  # System State Version
  system.stateVersion = "24.11"; # Did you read the comment?

  # Allow Unfree Packages (like Spotify, Steam)
  nixpkgs.config.allowUnfree = true;
}
