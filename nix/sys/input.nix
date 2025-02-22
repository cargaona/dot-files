{ pkgs,  ... }:
{
  services.libinput = {
    enable = true;
    touchpad.disableWhileTyping = true;
  }

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ]; # Apply to all keyboards
          settings = {
            main = {
              leftcontrol = "fn";
              fn = "leftcontrol";
              capslock = "overload(caps, esc)"; # Tap for Escape, hold for Caps Lock layer
            };
            caps = {
              h = "left";
              j = "down";
              k = "up";
              l = "right";
            };
          };
        extraConfig = ''
# Additional keyd configuration (if needed)
          '';
      };
    };
  };
}
