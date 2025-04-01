{
  pkgs,
  ...
}:

let
  # Common paths
  # hyprlandSocket = builtins.getEnv "HYPRLAND_INSTANCE_SIGNATURE";
  homeDir = "/home/char";
  projectDir = "/home/char/projects/personal/code";
  # resumeScript = pkgs.writeShellScriptBin "resume-script" ''
  #   #!${pkgs.bash}/bin/bash
  #   export PATH=${
  #     lib.makeBinPath [
  #       pkgs.hyprland
  #       pkgs.procps
  #       pkgs.swayidle
  #       pkgs.coreutils
  #     ]
  #   }

in
# echo $HYPRLAND_INSTANCE_SIGNATURE
# which killall
# which hyprctl
# hyprctl dispatch dpms on
# killall swayidle
# swayidle -w \
#   timeout 10 'hyprlock' \
#   timeout 15 'hyprctl dispatch dpms off && sleep 1 && systemctl suspend' \
#   before-sleep 'hyprlock' &
# ''
# ;

{
  # Systemd service to handle resume
  # systemd.user.services."swayidle-resume" = {
  #   # Unit = {
  #   enable = true;
  #   description = "Reset swayidle after suspend";
  #   after = [ "suspend.target" ];
  #   # };
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = "${resumeScript}/bin/resume-script";
  #     Environment = [
  #       "HYPRLAND_INSTANCE_SIGNATURE=${hyprlandSocket}"
  #     ];
  #   };
  #   # Install = {
  #   wantedBy = [ "sleep.target" ];
  #   # };
  # };
  # --- User Definitions ---
  users.users.char = {
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCiytR0RDJVFPwlPA+yBKUc6KhukzlPHCZ3ckaEZz5f5cXHp3g5dKZyOd7Kju7fEWa0apb37W9QZPa1PvreeJu6wpBs7FSNC6NpyjwnRjfpfbU1XC8WEVLzzgke+dV/7Ap98K2qpUoYAFIbYlAdGJAzMOc9BYKrb6l2ARIA26Fc2Zd7fUkdr8jcMQFv5qnFju1e82iPggeymNHKd7RNkuAg4nAfkTwNKxzcoF3rTBCc0iG0TE61uUbVOx6CVS/17Xj7g+YKS2jMuDE3nWi3Fl1PUx5J07DVFF4TzyxM2Srn8V39QSoCQDevyN1PZJcRW34GtgG2y1EEfJNVR1sP+GHak037L78JSyLfaDTB3uJzICOTdifFrc88SuauU+KMyyMnrP3h2YuWWurtOAZMGpPZlocFt8ILpC9j43fRtNbLwVe3dPTJDlDJJTZMjEVNrT1S6Xi6r7bYpq5jZgWNvPqByHnySrMsSwIGbuFfPoawVzbye6uliK8REiQV1azlMn0Lmv+YRwTURnpyiDmyAR3OxrB0CN9a0B8MLzp+IY1ZrLBxMCC/yRIWih2dOiLTri45qrt4Sul2NZYYPM9I2iwA8xezvp/Dr27gUKkixQVsCprRT8+J6fYVcVDOnzkDej/Hyem6oJqsGeSkjCmGCebBqJvxd5ZODD74A5HZzkLcrQ== cardno:15_206_941"
    ];
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

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # --- Services ---
  services.dbus.enable = true;

  # --- Home Manager Configurations ---
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "backup";

  home-manager.users.char =
    { pkgs, config, ... }:
    {
      # Enable Home Manager for user
      programs.home-manager.enable = true;

      # --- Password Store ---
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

      # Home Manager Specific Settings
      home.username = "char";
      home.homeDirectory = homeDir;
      home.sessionPath = [
        "/home/char/.cache/npm/global/bin/"
        "/home/char/projects/personal/code/dot-files/scripts/"
      ];
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
        #scripts = {
        #recursive = true;
        #target = "/bin/";
        #source = "${projectDir}/dot-files/scripts";
        #};
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
