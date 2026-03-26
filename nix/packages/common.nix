{
  pkgs,
  lib,
  unstable,
  config,
  ...
}:
{
  # Import categorized package modules
  imports = [
    ./cli.nix
    ./dev.nix
    ./desktop.nix
    ./infrastructure.nix
  ];
}

