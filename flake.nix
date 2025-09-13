{
  description = "NixOS configuration with multiple hosts";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs, home-manager, agenix, ... }@inputs:
  let
    system = "x86_64-linux";

    # Common modules shared across all systems
    commonModules = [
      agenix.nixosModules.default
      ./modules/system
      ./modules/hardware
      ./profiles/base.nix
      ./users/default.nix
    ];
  in {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules ++ [
          ./hosts/laptop/hardware-configuration.nix
          ./hosts/laptop/default.nix
          ./profiles/desktop.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.user1 = import ./users/user1/home.nix;
              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
        specialArgs = { inherit inputs; };
      };

      server = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules ++ [
          ./hosts/server/hardware-configuration.nix
          ./hosts/server/default.nix
          ./profiles/development.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
