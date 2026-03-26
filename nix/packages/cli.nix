{
  pkgs,
  lib,
  unstable,
  ...
}:
{
  environment.systemPackages =
    with pkgs;
    lib.optionals pkgs.stdenv.isLinux [
      # Shell & terminal utilities
      autojump
      bc
      curl
      dig
      fd
      fzf
      gnupg
      killall
      lsof
      ncdu
      nmap
      oh-my-zsh
      ripgrep
      sudo
      tcpdump
      tldr
      tmux
      tmuxinator
      tree
      unzip
      usbutils
      wget
      yazi # Terminal file manager
      yq-go
      zbar
      zenity
      zsh-completions
      zsh-history-substring-search
      zsh-powerlevel10k
      zsh-syntax-highlighting

      # System monitoring & management
      brightnessctl
      btop
      htop
      powertop

      # Networking tools
      awscli
      iw

      # Media & Image tools
      ffmpeg
      imagemagick
      moc # Music on Console

      # Wayland/Graphics utilities
      grim
      hyprpicker
      hyprshot
      slurp
      swappy
      swayidle
      wl-clipboard

      # System libraries & utilities
      glib
      jetbrains-mono
      jq
      libinput
      libnotify
      lua
      matugen
      magic-wormhole
      ntfs3g
      pamixer
      phinger-cursors
      playerctl
      tesseract

      # Text editors
      neovim

      # News & RSS
      newsboat

      # Misc tools
      unstable.opencode
    ];

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    ohMyZsh = {
      enable = true;
      custom = if pkgs.stdenv.isLinux then "/home/char/.zshrc" else "/Users/char/.zshrc";
      plugins = [
        "git"
        "autojump"
        "vi-mode"
        "kube-ps1"
      ];
    };
  };
}
