{
  pkgs,
  lib,
  unstable,
  config,
  # mpris-inhibit,
  # isolation,
  ...
}:
let
  # Detect platform
  isSFF = config.networking.hostName == "sff";
  isLinux = pkgs.stdenv.isLinux;

  # Linux-specific packages
  desktopPackages =
    with pkgs;
    lib.optionals isSFF [
      davinci-resolve
      mongodb-compass
      clementine
      stremio
      vesktop
      obs-studio
      obsidian
      pomodoro-gtk
    ];

  commonPackages =
    with pkgs;
    lib.optionals isLinux [
      # isolation.packages.${pkgs.system}.default
      # mpris-inhibit.packages.${pkgs.system}.default
      # dmx.packages.${pkgs.system}.default
      alacritty
      alacritty-theme
      autojump
      awscli
      bash-language-server
      bc
      # beets
      black # Python code formatter
      brave
      brightnessctl
      btop
      calibre
      cargo
      ccls
      claude-code
      cliphist
      cni-plugin-flannel
      cni-plugins
      curl
      deluge
      dig
      discord
      docker # TODO: Remove after server migration to Podman
      dunst
      electron
      fd
      feh
      ffmpeg
      firefox
      fzf
      gcc
      git
      glib
      gnumake
      gnupg
      go
      gopls
      grim
      htop
      iw
      jetbrains-mono
      jq
      k9s
      killall
      kubectl
      kubectl-neat
      kubectx
      kubernetes-helm
      libinput
      lsof
      lua
      lua-language-server
      luarocks
      magic-wormhole
      moc
      nautilus
      ncdu
      neovim
      newsboat
      nil
      nixfmt-rfc-style
      nmap
      nodejs_latest
      ntfs3g
      oh-my-zsh
      pamixer
      pavucontrol
      phinger-cursors
      podman
      podman-compose
      powertop
      pyright
      python3
      python312Packages.pip
      # python312Packages.drop2beets
      ripgrep
      rockbox-utility
      rofi-wayland
      runc
      scrcpy
      slack
      slurp
      soulseekqt
      spotify
      streamrip
      sudo
      swappy
      swayidle
      syncthing
      tcpdump
      telegram-desktop
      terraform
      terraform-ls
      tflint
      tldr
      tmux
      tree
      tree-sitter
      typescript-language-server
      unstable.opencode
      unzip
      usbutils
      uv
      vim
      virtualenv
      vlc
      waybar
      wdisplays
      wf-recorder
      wget
      wireshark
      wl-clipboard
      wofi
      yaml-language-server
      yarn
      yazi
      yq-go
      zbar
      zenity
      zsh-completions
      zsh-history-substring-search
      zsh-powerlevel10k
      zsh-syntax-highlighting
    ];
in
{
  environment.systemPackages = commonPackages ++ desktopPackages;
  systemd.tmpfiles.rules = [
    "d /opt/cni/bin 0755 root root -"

    # 2. Link the CONTENTS of the plugins folder into it (note the /*)
    "L+ /opt/cni/bin/loopback - - - - ${pkgs.cni-plugins}/bin/loopback"
    "L+ /opt/cni/bin/bridge   - - - - ${pkgs.cni-plugins}/bin/bridge"
    "L+ /opt/cni/bin/flannel  - - - - ${pkgs.cni-plugin-flannel}/bin/flannel"

    # Optional: Just link everything from cni-plugins to be safe
    "L+ /opt/cni/bin/bandwidth  - - - - ${pkgs.cni-plugins}/bin/bandwidth"
    "L+ /opt/cni/bin/portmap  - - - - ${pkgs.cni-plugins}/bin/portmap"
    "L+ /opt/cni/bin/host-local - - - - ${pkgs.cni-plugins}/bin/host-local"
    "L+ /usr/bin/nvidia-container-runtime - - - - ${pkgs.nvidia-container-toolkit}/bin/nvidia-container-runtime"
  ];
  # Shared program configurations
  programs.steam.enable = isLinux;
  # programs.firefox.enable = true; # Cross-platform: works on Linux and macOS
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    ohMyZsh = {
      enable = true;
      custom = if isSFF then "/Users/char/.zshrc" else "/home/char/.zshrc";
      plugins = [
        "git"
        "autojump"
        "vi-mode"
        "kube-ps1"
      ];
    };
  };
}
