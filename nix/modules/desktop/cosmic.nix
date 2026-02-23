{
  pkgs,
  config,
  lib,
  ...
}:
let
  unstable = import <nixos-unstable> {
    config = {
      allowUnfree = true;
    };
  };
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

  environment.variables = {
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11";
    # QT_QPA_PLATFORM = "wayland;xcb";
    LIBVA_DRIVER_NAME = "nvidia";
    XMODIFIERS = "@im=ibus";
    MOZ_DBUS_REMOTE = "1";
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    MOZ_ENABLE_WAYLAND = "1";
    # MOZ_USE_XINPUT2 = "1";
    GDK_SCALE = "1";
    GBM_BACKEND = "nvidia-drm";
    BROWSER = "firefox.desktop";
    TERMINAL = "alacritty";
    QT_QPA_PLATFORMTHEME = "gtk";
    SDL_VIDEODRIVER = "wayland";
    QT_SCALE_FACTOR = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    # WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
    CLUTTER_BACKEND = "wayland";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # GTK_USE_PORTAL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";
  };
}
