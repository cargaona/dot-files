{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };
  outputs =
    { nixpkgs, ... }:
    {
      nixosConfigurations = {
        "desktop" = nixpkgs.lib.nixosSystem {
          modules = [
            /etc/nixos/hosts/desktop/configuration.nix
          ];
        };
        "server" = nixpkgs.lib.nixosSystem {
          modules = [
            /etc/nixos/hosts/server/configuration.nix
          ];
        };
      };
    };
}
