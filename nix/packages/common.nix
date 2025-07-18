{ pkgs, lib, ... }:
let
  # Detect platform
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
  
  # Shared packages (work on both platforms)
  sharedPackages = with pkgs; [
    alacritty
    alacritty-theme
    autojump
    awscli
    bash-language-server
    bc
    beets
    btop
    ccls
    claude-code
    curl
    fd
    feh
    ffmpeg
    fzf
    gcc
    git
    glib
    gnumake
    gnupg
    go
    gopls
    htop
    jq
    killall
    kubectl
    kubectl-neat
    kubectx
    lua
    lua-language-server
    luarocks
    magic-wormhole
    ncdu
    neovim
    newsboat
    nil
    nixfmt-rfc-style
    nmap
    nodejs_latest
    obs-studio
    obsidian
    oh-my-zsh
    python3
    python312Packages.pip
    ripgrep
    rockbox-utility
    scrcpy
    slack
    spotify
    stremio
    sudo
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
    unzip
    usbutils
    uv
    vesktop
    vim
    vlc
    wget
    yaml-language-server
    yarn
    yazi
    yq-go
    zbar
    zsh-completions
    zsh-history-substring-search
    zsh-powerlevel10k
    zsh-syntax-highlighting
  ];
  
  # Linux-specific packages
  linuxPackages = with pkgs; lib.optionals isLinux [
    brightnessctl
    cliphist
    davinci-resolve
    deluge
    dig
    discord
    docker  # TODO: Remove after server migration to Podman
    dunst
    electron
    grim
    hyprpaper
    iw
    jetbrains-mono
    libinput
    moc
    mongodb-compass
    pamixer
    pavucontrol
    phinger-cursors
    podman
    podman-compose
    powertop
    pyright
    rofi-wayland
    slurp
    soulseekqt
    swappy
    swayidle
    waybar
    wdisplays
    wf-recorder
    wl-clipboard
    wofi
    zenity 
  ];
  
  # macOS-specific packages  
  darwinPackages = with pkgs; lib.optionals isDarwin [
    # Add macOS-specific packages here
    # We'll add these as needed
  ];
in
{
  environment.systemPackages = sharedPackages ++ linuxPackages ++ darwinPackages;
  
  # Shared program configurations
  programs.steam.enable = isLinux;
  programs.firefox.enable = true;  # Cross-platform: works on Linux and macOS
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    ohMyZsh = {
      enable = true;
      custom = if isDarwin then "/Users/char/.zshrc" else "/home/char/.zshrc";
      plugins = [
        "git"
        "autojump"
        "vi-mode"
        "kube-ps1"
      ];
    };
  };
}
