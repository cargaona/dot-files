{
  lib,
  pkgs,
  config,
  ...
}:
let
  unstable = import <nixos-unstable> {
    config = {
      allowUnfree = true;
    };
  };
in
{
  # Enable Graphics (Hyprland needs to be enable at a systems level)
  environment.systemPackages = [
    unstable.wayland-scanner
    # inputs.swww.packages.${pkgs.system}.swww

    ## TODO, move this package to other place. 
    # unstable.obs-studio-plugins.distroav
    unstable.swww
    unstable.nwg-look
    #unstable.hyprland
    #unstable.hyprgui
    #unstable.hyprcursor
    unstable.hyprlock
    unstable.hypridle
    unstable.xcur2png
    unstable.hyprland-protocols
    unstable.wev
    unstable.hyprland-workspaces
    # hyprdim
    unstable.xdg-desktop-portal-gtk
    unstable.xdg-desktop-portal-hyprland
    unstable.xwayland
    unstable.aquamarine
    unstable.wlroots
  ];

  # systemd.user.services.hyprpaper = {
  #   enable = true;
  # };

  environment.localBinInPath = true;

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
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    GTK_USE_PORTAL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [
        "gtk"
        "hyprland"
      ];
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };
}
