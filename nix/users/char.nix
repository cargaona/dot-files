{ pkgs, ... }:

let
  # Common paths
  homeDir = "/home/char";
  projectDir = "/home/char/projects/personal/code";
in

{
  # --- User Definitions ---
  users.users.char = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user
    packages = with pkgs; [
      tree
    ];
  };

  # Default user shell (Zsh)
  users.defaultUserShell = pkgs.zsh;

  # --- Security Settings ---
  security.sudo.enable = true;

  # --- Services ---
  services.dbus.enable = true;

  # --- Home Manager Configurations ---
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";

  home-manager.users.char = { pkgs, config, ... }: {
    # Enable Home Manager for user
    programs.home-manager.enable = true;

    # Home Manager Specific Settings
    home.username = "char";
    home.homeDirectory = homeDir;

    # --- Password Store ---
    programs.password-store = {
      enable = true;
      package = pkgs.pass-wayland.withExtensions (exts: with exts; [
        pass-otp
        pass-import
        pass-audit
      ]);
      settings.PASSWORD_STORE_DIR = "${homeDir}/.password-store";
    };

    # --- Session Environment Variables ---
    home.sessionVariables = {
      MY_FOLDER = homeDir;
      CODE_PATH = "${homeDir}/projects/personal/code/";
      EDITOR = "nvim";
    };

    # --- File Syncing ---
    home.file = {
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
        target = ".config/nvim/";
        source = "${projectDir}/dot-files/nvim";
      };
      rofi = {
        recursive = false;
        target = ".config/rofi/config.rasi";
        source = "${projectDir}/dot-files/rofi/config.rasi";
      };
      rofi-theme = {
        recursive = false;
        target = ".local/share/rofi/themes/nord.rasi";
        source = "${projectDir}/dot-files/rofi/nord.rasi";
      };
      waybar = {
        recursive = true;
        target = ".config/waybar";
        source = "${projectDir}/dot-files/waybar";
      };
    };

    # --- Dconf Settings ---
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };

    # --- Home Manager Version ---
    home.stateVersion = "24.11";
  };

  # --- Shell Configurations ---
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      custom = "${homeDir}/.zshrc";
      plugins = [
        "git"
        "autojump"
        "vi-mode"
        "kube-ps1"
      ];
    };
  };
}
