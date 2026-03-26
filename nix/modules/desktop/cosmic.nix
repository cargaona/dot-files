{
  pkgs,
  config,
  lib,
  unstable,
  ...
}:
let
  dmcfg = config.services.displayManager;
in
{
  # Enable the COSMIC login manager
  services.displayManager.cosmic-greeter.enable = true;

  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;

  # Fix session discovery: cosmic-greeter's wrapper doesn't include sessionData.desktops
  # We inject XDG_DATA_DIRS into the greetd environment before cosmic-greeter starts
  systemd.services.greetd.environment.XDG_DATA_DIRS = lib.mkForce (
    "${dmcfg.sessionData.desktops}/share"
  );

  # Enable Graphics (Hyprland needs to be enable at a systems level)
  environment.systemPackages = [
    unstable.wayland-scanner

    # unstable.swww
    # unstable.nwg-look
    #unstable.hyprland
    #unstable.hyprgui
    #unstable.hyprcursor
    unstable.xcur2png
    # unstable.wev
    # hyprdim
    # unstable.xdg-desktop-portal
    # unstable.xdg-desktop-portal-gtk
    # unstable.xdg-desktop-portal-hyprland
    # unstable.wlroots
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-cosmic
    ]; # For non-COSMIC app compatibility
    config.common.default = [
      "cosmic"
      "gtk"
    ];
  };

  # Environment variables are defined in hyprland.nix as the single source of truth
  # COSMIC will inherit these system-wide settings via environment.variables
}
