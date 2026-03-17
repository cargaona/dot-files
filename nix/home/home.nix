{ pkgs, lib, ... }:
let
  # Detect platform
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  # Platform-specific paths
  homeDir = if isDarwin then "/Users/char" else "/home/char";
  projectDir = "${homeDir}/projects/personal/code";

  # Define the drop2beets package
  drop2beets = pkgs.python3Packages.buildPythonPackage rec {
    pname = "drop2beets";
    version = "2.1.0";
    pyproject = true;
    src = pkgs.python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-PK0U4doAHlvwHBDyf8M76CsMQov6X5Eim/U0jv16oV0=";
    };
    build-system = with pkgs.python3Packages; [
      poetry-core
    ];
    doCheck = false;
    propagatedBuildInputs = with pkgs.python3Packages; [
      watchdog
    ];
  };

  # Wrap beets so it includes the plugin
  beetsWithPlugins = pkgs.beets.override {
    pluginOverrides = {
      drop2beets = {
        enable = true;
        propagatedBuildInputs = [ drop2beets ];
      };
    };
  };
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

  programs.beets = {
    enable = true;
    package = beetsWithPlugins;
    settings = {
      directory = "/mnt/seagate/music/";
      move = true;
      delete = true;
      asciify_path = true;

      plugins = [
        "missing"
        "web"
        "fetchart"
        "embedart"
        "duplicates"
        "musicbrainz"
        "drop2beets"
      ];

      paths = {
        "albumtype:ep" = "$albumartist/$album [EP] ($original_year)/$track - $title";
        "albumtype:single" = "$albumartist/$album [Single] ($original_year)/$track - $title";
        default = "$albumartist/$album ($original_year)/$track - $title";
      };

      drop2beets = {
        debounce_window = 60;
        dropbox_paths = {
          default = "/mnt/nvme/tlmsc/staging/";
        };
      };

      fetchart = {
        quality = 65;
        sources = "coverart itunes amazon fanarttv";
        store_source = true;
        auto = true;
        maxwidth = 300;
      };

      embedart = {
        auto = true;
        maxwidth = 300;
      };
    };
  };
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
    # }
  };

  # Linux-specific dconf settings
  dconf = lib.mkIf isLinux {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.stateVersion = "25.05";
}
