{
  description = "NixOS configuration with multiple machines";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Tilføj evt. flere inputs her
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      # System typer vi understøtter
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      # Import custom lib functions
      helpers = import ./lib/helpers.nix;

      # Import overlays fra default.nix
      overlays = import ./overlays/default.nix;

      # Common special args (uden flakeRoot)
      commonSpecialArgs = {
        inherit inputs helpers overlays;
      };
    in {
      # NixOS configs
      nixosConfigurations = {
        # Lenovo host
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

        # nixos-btw host
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

        # Server host
        server = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = commonSpecialArgs;
          modules = [
            ./hosts/server/default.nix
            ./hosts/server/hardware-configuration.nix
          ];
        };
      };

      # DevShell (valgfri)
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

      # Formatter (valgfri)
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}
