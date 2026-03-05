{ pkgs, unstable, ... }:
{
  # Fonts
  fonts.packages = [
    pkgs.jetbrains-mono
    unstable.nerd-fonts.jetbrains-mono
    pkgs.material-symbols
    pkgs.google-fonts
    pkgs.twitter-color-emoji
  ];
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  fonts.fontconfig = {
    defaultFonts = {
      serif = [
        "Liberation Serif"
        "Vazirmatn"
      ];
      sansSerif = [
        "Ubuntu"
        "Vazirmatn"
      ];
      monospace = [ "Ubuntu Mono" ];
    };
  };
}
