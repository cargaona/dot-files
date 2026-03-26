{
  pkgs,
  lib,
  config,
  claude-desktop,
  ...
}:
let
  isDesktop = config.host.isDesktop or false;

  # Wrap claude-desktop to force X11/Xwayland mode for OAuth popup compatibility
  claude-desktop-x11 = pkgs.symlinkJoin {
    name = "claude-desktop-x11";
    paths = [ claude-desktop.packages.${pkgs.system}.claude-desktop-with-fhs ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/claude-desktop \
        --unset NIXOS_OZONE_WL \
        --add-flags "--disable-features=UseOzonePlatform" \
        --add-flags "--ozone-platform=x11"
    '';
  };
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
      claude-desktop-x11
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
