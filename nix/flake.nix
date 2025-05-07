{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
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
