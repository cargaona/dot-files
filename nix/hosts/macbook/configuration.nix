{ pkgs, lib, ... }:
{
  imports = [
    ../../packages/common.nix
    ../../users/char.nix
  ];

  # Enable nix-darwin
  services.nix-daemon.enable = true;
  
  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  
  # Home Manager integration
  home-manager.users.char = import ../../home/home.nix;

  # macOS-specific system settings
  system.defaults = {
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.GuestEnabled = false;
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.InitialKeyRepeat = 14;
    NSGlobalDomain.KeyRepeat = 1;
  };

  # Homebrew integration (optional)
  homebrew = {
    enable = true;
    brews = [
      "aerospace"
    ];
    casks = [
      "raycast"
      "obsidian"
      "discord"
      "spotify"
      "vlc"
    ];
  };

  # Fonts
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerdfonts
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 4;
}