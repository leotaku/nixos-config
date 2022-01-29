{
  description = "My overlays and local system";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      flake = true;
    };
  };

  outputs = { self, nixpkgs, ... }:
    let
      final = self.legacyPackages.x86_64-linux;
      prev = import nixpkgs {
        config.allowUnfree = true;
        system = "x86_64-linux";
      };
      mod = { ... }: {
        nix = {
          extraOptions = let
            registry = builtins.toFile "empty-flake-registry.json"
              (builtins.toJSON {
                "flakes" = [ ];
                "version" = 2;
              });
          in ''
            experimental-features = nix-command flakes
            flake-registry = ${registry}
          '';
          registry.nixpkgs.flake = nixpkgs;
          nixPath = [ "nixpkgs=${nixpkgs}" ];
        };
        nixpkgs = {
          overlays = [ self.overlay ];
        };
      };
    in {
      # Systems
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ (import ./deployments/laptop/configuration.nix) mod ];
        };
        fujitsu = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ (import ./deployments/fujitsu.nix) mod ];
        };
        rpi = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [ (import ./deployments/rpi.nix) mod ];
        };
      };

      # Custom overlay
      overlay = import ./pkgs/default.nix;

      # Package set with overlay
      legacyPackages.x86_64-linux = prev.extend self.overlay;
    };
}
