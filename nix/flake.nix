{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
  };
  outputs =
    { nixpkgs, nixpkgs-darwin, darwin, home-manager, ... }:
    {
      nixosConfigurations = {
        "desktop" = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/desktop/configuration.nix
            home-manager.nixosModules.home-manager
          ];
          specialArgs = {
            inherit home-manager;
          };
        };
        "server" = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/server/configuration.nix
          ];
        };
      };
      
      darwinConfigurations = {
        "macbook" = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            ./hosts/macbook/configuration.nix
            home-manager.darwinModules.home-manager
          ];
          specialArgs = {
            inherit home-manager;
          };
        };
      };
    };
}
