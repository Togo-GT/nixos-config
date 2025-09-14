{
  description = "NixOS configuration with multiple machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add other inputs you might need
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      # System types to support
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];

      # Helper function to generate systems
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Import custom lib functions
      helpers = import ./lib/helpers.nix;

      # Import overlays from default.nix file
      overlays = import ./overlays/default.nix;

      # Common special args for all configurations
      commonSpecialArgs = {
        inherit inputs helpers overlays;
        # Fjern flakeRoot - det forårsager problemer
      };

    in {
      # NixOS configurations
      nixosConfigurations = {
        # Laptop configurations
        "lenovo-i7" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = commonSpecialArgs;
          modules = [
            ./hosts/laptop/lenovo-i7/configuration.nix
            ./hosts/laptop/lenovo-i7/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.gt = import ./users/gt/home.nix;
            }
          ];
        };

        "nixos-btw" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = commonSpecialArgs;
          modules = [
            ./hosts/laptop/nixos-btw/configuration.nix
            ./hosts/laptop/nixos-btw/hardware-configuration.nix
            ./modules/system/stateversion.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.gt = import ./users/gt/gt.nix;
            }
          ];
        };

        # Server configuration
        server = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = commonSpecialArgs;
          modules = [
            ./hosts/server/default.nix
            ./hosts/server/hardware-configuration.nix
          ];
        };
      };

      # Development shell (optional)
      devShells = forAllSystems (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nixpkgs-fmt
              statix
              deadnix
            ];
          };
        }
      );

      # Formatter for your nix code (optional)
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}
