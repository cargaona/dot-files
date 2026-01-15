{
  inputs = {
    # 1. add the urls of the flakes you want to use
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
    dmx.url = "github:cargaona/dmx";
    mpris-inhibit.url = "github:/Bwc9876/wayland-mpris-idle-inhibit";
    # isolation.url = "path:/home/char/projects/personal/code/isolation";
  };
  outputs =
    # 2. define the variables you want to use in the flake, usually the name of the input already defined previously.
    {
      nixpkgs,
      nixpkgs-unstable,
      # nixpkgs-darwin,
      darwin,
      home-manager,
      dmx,
      mpris-inhibit,
      # isolation,
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
            # 3. pass the variables to the system configuration
            # 4. reference the modules inside the configuration.nix files, not here!  
            inherit
              home-manager
              dmx
              mpris-inhibit
              # isolation
              ;
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
