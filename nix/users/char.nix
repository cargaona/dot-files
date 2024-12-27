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
      };

      home.stateVersion = "24.11";
    };
}
