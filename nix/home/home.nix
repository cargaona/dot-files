{ pkgs, lib, ... }:
let
  # Detect platform
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  # Platform-specific paths
  homeDir = if isDarwin then "/Users/char" else "/home/char";
  projectDir = "${homeDir}/projects/personal/code";
in
{
  programs.home-manager.enable = true;

  home.username = "char";
  home.homeDirectory = homeDir;

  # Suppress version mismatch warning
  home.enableNixpkgsReleaseCheck = false;

  home.sessionVariables = {
    MY_FOLDER = homeDir;
    CODE_PATH = "${homeDir}/projects/personal/code/";
    EDITOR = "nvim";
  };

  home.sessionPath = [
    "/home/char/projects/personal/code/dot-files/scripts"
  ];

  # Password store (Linux only for now, uses wayland extensions)
  programs.password-store = lib.mkIf isLinux {
    enable = true;
    package = pkgs.pass-wayland.withExtensions (
      exts: with exts; [
        pass-otp
        pass-import
        pass-audit
      ]
    );
    settings.PASSWORD_STORE_DIR = "${homeDir}/.password-store";
  };

  # Shared dotfiles (work on both platforms)
  home.file = {
    scripts = {
      recursive = true;
      target = "./local/bin/";
      source = "${projectDir}/dot-files/scripts";
    };
    ".local/bin/xdg-open".text = ''
      #!/usr/bin/env bash
      if [[ "$1" =~ ^https?:// ]]; then
          firefox "$1" &
      else
          /run/current-system/sw/bin/xdg-open "$@"
      fi
    '';
    ".local/bin/xdg-open".executable = true;
    newsboat = {
      recursive = true;
      target = "./.newsboat";
      source = "${projectDir}/dot-files/newsboat";
    };
    custom-zsh = {
      recursive = false;
      target = ".zshrc";
      source = "${projectDir}/dot-files/zsh/.zshrc";
    };
    tmux = {
      recursive = false;
      target = "./.tmux.conf";
      source = "${projectDir}/dot-files/tmux/.tmux.conf";
    };
    alacritty = {
      recursive = true;
      target = ".config/alacritty/";
      source = "${projectDir}/dot-files/alacritty";
    };
    nvim = {
      recursive = true;
      target = ".config/nvim";
      source = "${projectDir}/dot-files/nvim";
    };
  }
  // lib.optionalAttrs isLinux {
    # Linux-specific dotfiles
    # hyprland = {
    #   recursive = true;
    #   target = "./.config/hypr/";
    #   source = "${projectDir}/dot-files/hypr";
    # };
    rofi = {
      recursive = false;
      target = ".config/rofi/config.rasi";
      source = "${projectDir}/dot-files/rofi/config.rasi";
    };
    rofi-theme = {
      recursive = false;
      target = ".local/share/rofi/themes/";
      source = "${projectDir}/dot-files/rofi/";
    };
    # waybar = {
    #   recursive = true;
    #   target = ".config/waybar";
    #   source = "${projectDir}/dot-files/waybar";
    # };
  }
  // lib.optionalAttrs isDarwin {
    # macOS-specific dotfiles
    aerospace = {
      recursive = true;
      target = ".config/aerospace/";
      source = "${projectDir}/dot-files/aerospace";
    };
  };

  # Linux-specific dconf settings
  dconf = lib.mkIf isLinux {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.stateVersion = "25.05";
}
