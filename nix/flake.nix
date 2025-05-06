{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  outputs =
    { nixpkgs, ... }:
    {
      nixosConfigurations = {
        "desktop" = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration.desktop.nix
            ./hosts/desktop/hardware-configuration.nix
          ];
        };
        "macbook" = nixpkgs.lib.nixosSystem {
          modules = [ ./configuration.notebook.nix ];
        };
        default = nixpkgs.lib.nixosSystem {
          modules = [ ./configuration.server.nix ];
        };
      };
    };
}
