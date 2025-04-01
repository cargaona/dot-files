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
      ./services/power.nix
      ./sys/fonts.nix
      ./sys/graphics.nix
      ./sys/input.nix
      ./users/char.nix
      /etc/nixos/hardware-configuration.nix
    ];

  nix.settings.experimental-features = ["nix-command"];
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
  networking.hostName = "sff";  # Define your hostname
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [7070 8096 8080 4443 8112];

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
