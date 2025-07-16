{ pkgs, ... }:

let
  homeDir = "/home/char";
  projectDir = "/home/char/projects/personal/code";
in
{
  programs.home-manager.enable = true;

  home.username = "char";
  home.homeDirectory = homeDir;

  home.sessionVariables = {
    MY_FOLDER = homeDir;
    CODE_PATH = "${homeDir}/projects/personal/code/";
    EDITOR = "nvim";
  };

  programs.password-store = {
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

  home.file = {
    scripts = {
      recursive = true;
      target = "./local/bin/";
      source = "${projectDir}/dot-files/scripts";
    };
    newsboat = {
      recursive = true;
      target = "./.newsboat";
      source = "${projectDir}/dot-files/newsboat";
    };
    hyprland = {
      recursive = true;
      target = "./.config/hypr/";
      source = "${projectDir}/dot-files/hypr";
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
    cursor = {
      recursive = false;
      target = "/home/char/.local/share/icons/rose-pine-hyprcursor/";
      source = "${projectDir}/dot-files/rose-pine-hyprcursor/";
    };
    waybar = {
      recursive = true;
      target = ".config/waybar";
      source = "${projectDir}/dot-files/waybar";
    };
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.stateVersion = "25.05";
}
