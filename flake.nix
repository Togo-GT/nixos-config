{
  description = "NixOS configuration with multiple machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Optional: Add home-manager if you're using it
    home-manager = {
      url = "github:nix-community/home-manager";
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

      # Import overlays (uncommented and fixed)
      overlays = import ./overlays;

      # Common special args for all configurations
      commonSpecialArgs = {
        inherit inputs helpers overlays;
        flakeRoot = self.outPath; # Add flake root path
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
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.gt = import ./users/gt/home.nix;
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
