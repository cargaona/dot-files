{ pkgs,  ... }:
{
  #https://github.com/NixOS/nixos-hardware/blob/master/apple/macbook-pro/14-1/default.nix
  services.libinput = {
    enable = true;
    touchpad.disableWhileTyping = true;
  }; 
  environment.etc."libinput/local-overrides.quirks".text = ''
    [MacBook(Pro) SPI Touchpads]
    MatchName=*Apple SPI Touchpad*
    ModelAppleTouchpad=1
    AttrTouchSizeRange=200:150
    AttrPalmSizeThreshold=1100

    [MacBook(Pro) SPI Keyboards]
    MatchName=*Apple SPI Keyboard*
    AttrKeyboardIntegration=internal
  '';

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ]; # Apply to all keyboards
          settings = {
            main = {
              #leftcontrol = "fn";
              #fn = "leftcontrol";
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
