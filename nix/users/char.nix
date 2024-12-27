{ ... }:
{
  users.users.char.isNormalUser = true;
  home-manager.useGlobalPkgs = true;
  services.dbus.enable = true;

  environment.variables = { };

  home-manager.backupFileExtension = "backup";

  home-manager.users.char =
    { pkgs,config, ... }:
    {
      # Enable/Disable deafult system programs
      programs.home-manager.enable = true;
      home.username = "char";
      home.homeDirectory = "/home/char";
      
      home.sessionVariables = {
        MY_FOLDER = "/home/char";
        CODE_PATH = "/home/char/projects/personal/code/";
        PASSWORD_STORE_DIR = "$MY_FOLDER/.pass";
        EDITOR = "nvim";
      };

     home.file = {
        newsboat = {
          recursive = true;
          target = "./.newsboat";
          source = /home/char/projects/personal/code/dot-files/newsboat;
        };
        hyprland = {
          recursive = true;
          target = "./.config/hypr/";
          source = /home/char/projects/personal/code/dot-files/hypr; 
        };
        custom-zsh = {
          # zsh installation takes the custom .zshrc from this symlink and
          # sources it. at the same time, this file sources the zsh theme. No
          # need to do an extra symlink. 
          recursive = false;
          target = ".zshrc";
          source = /home/char/projects/personal/code/dot-files/zsh/.zshrc; 
        };
        tmux = {
          recursive = false;
          target = "./.tmux.conf";
          source = /home/char/projects/personal/code/dot-files/tmux/.tmux.conf;
        };
        alacritty = {
          recursive = true;
          target = ".config/alacritty/";
          source = /home/char/projects/personal/code/dot-files/alacritty;
        };
        nvim = {
          recursive = true;
          target = ".config/nvim/";
          source = /home/char/projects/personal/code/dot-files/nvim; 
        };
        rofi = {
          recursive = false;
          target = ".config/rofi/config.rasi";
          source = /home/char/projects/personal/code/dot-files/rofi/config.rasi;
        };
        rofi-theme = {
          recursive = false;
          target = ".local/share/rofi/themes/nord.rasi";
          source = /home/char/projects/personal/code/dot-files/rofi/nord.rasi;
        };
        waybar = {
          recursive = true;
          target = ".config/waybar";
          source = /home/char/projects/personal/code/dot-files/waybar; 
        };
      };

      home.stateVersion = "24.11";
    };
}
