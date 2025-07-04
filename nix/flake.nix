{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
  };
  outputs =
    { nixpkgs, nixos-cosmic, ... }:
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
        "macbook" = nixpkgs.lib.nixosSystem {
          modules = [
            {
              nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
              };
            }
            nixos-cosmic.nixosModules.default
            /etc/nixos/hosts/notebook/configuration.nix
          ];
        };
      };
    };
}
