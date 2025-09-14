{
  description = "NixOS configuration with multiple machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      supportedSystems = [ "x86_64-linux" ];
      commonSpecialArgs = { inherit inputs; };
    in {
      nixosConfigurations = {
        "nixos-btw" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = commonSpecialArgs;
          modules = [
            ./hosts/laptop/nixos-btw/configuration.nix
            ./hosts/laptop/nixos-btw/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.gt = import ./users/gt/home.nix;
            }
          ];
        };
      };
    };
}
