{
  pkgs,
  lib,
  config,
  ...
}:
let
  isDesktop = config.host.isDesktop or false;
in
{
  environment.systemPackages =
    with pkgs;
    lib.optionals pkgs.stdenv.isLinux [
      # Terminal emulators
      alacritty
      alacritty-theme

      # Web browsers
      brave
      firefox

      # Media & Entertainment
      # calibre
      deluge
      spotify
      streamrip
      vlc

      # Communication
      slack
      telegram-desktop

      # File management & viewers
      feh
      nautilus

      # Wayland/Desktop utilities
      fuzzel
      pavucontrol
      rofi
      waybar
      wdisplays
      wlogout
      wofi

      # Screen recording & capture
      scrcpy
      wf-recorder
      wireshark

      # Electron apps
      electron
    ]
    ++ lib.optionals isDesktop [
      # Desktop-only GUI applications (heavier apps)
      beets
      clementine
      davinci-resolve
      obs-studio
      obsidian
      pomodoro-gtk
      rockbox-utility
      #stremio
      vesktop
    ];

  # Desktop-specific program configurations
  programs.steam.enable = lib.mkIf isDesktop true;
}
