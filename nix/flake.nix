{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
    dmx.url = "github:cargaona/dmx";
    mpris-inhibit.url = "github:/Bwc9876/wayland-mpris-idle-inhibit";
  };
  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      # nixpkgs-darwin,
      darwin,
      home-manager,
      dmx,
      mpris-inhibit,
      ...
    }:
    {
      nixosConfigurations = {
        "desktop" = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/desktop/configuration.nix
            home-manager.nixosModules.home-manager
          ];
          specialArgs = {
            inherit home-manager dmx mpris-inhibit;
            unstable = import nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
        };
        "server" = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/server/configuration.nix
          ];
          specialArgs = {
            inherit dmx;
            unstable = import nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
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
