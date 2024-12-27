{ ... }:
{
  users.users.char.isNormalUser = true;
  home-manager.useGlobalPkgs = true;
  services.dbus.enable = true;

  environment.variables = { };

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
      };

      home.stateVersion = "24.11";
    };
}
