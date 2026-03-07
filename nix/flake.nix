{
  inputs = {
    # 1. add the urls of the flakes you want to use
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    caelestia-shell.url = "github:caelestia-dots/shell";
    ambxst.url = "github:Axenide/Ambxst";
    dmx.url = "github:cargaona/dmx";
    mpris-inhibit.url = "github:/Bwc9876/wayland-mpris-idle-inhibit";
    # isolation.url = "path:/home/char/projects/personal/code/isolation";
  };
  outputs =
    # 2. define the variables you want to use in the flake, usually the name of the input already defined previously.
    {
      nixpkgs,
      nixpkgs-unstable,
      darwin,
      home-manager,
      caelestia-shell,
      ambxst,
      dmx,
      mpris-inhibit,
      ...
    }:
    {
      nixosConfigurations = {
        "costanza" = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/costanza/configuration.nix
            home-manager.nixosModules.home-manager
          ];
          specialArgs = {
            # 3. pass the variables to the system configuration
            # 4. reference the modules inside the configuration.nix files, not here!
            inherit
              home-manager
              caelestia-shell
              ambxst
              dmx
              mpris-inhibit
              ;
            unstable = import nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
        };
        "kramer" = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/kramer/configuration.nix
            home-manager.nixosModules.home-manager
          ];
          specialArgs = {
            inherit home-manager dmx;
            unstable = import nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
        };
        "elaine" = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/elaine/configuration.nix
            home-manager.nixosModules.home-manager
          ];
          specialArgs = {
            inherit home-manager dmx;
            inherit caelestia-shell ambxst mpris-inhibit;
            unstable = import nixpkgs-unstable {
              system = "x86_64-linux";
              config.allowUnfree = true;
            };
          };
        };
      };
    };
}
