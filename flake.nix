{
  description = "My overlays and local system";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable-small";
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
    in {
      # Systems
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ (import ./deployments/laptop/configuration.nix) ];
        };
        fujitsu = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ (import ./deployments/fujitsu.nix) ];
        };
        rpi = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [ (import ./deployments/rpi.nix) ];
        };
      };

      # Custom overlay
      overlay = import ./pkgs/default.nix;

      # Package set with overlay
      legacyPackages.x86_64-linux = prev // (self.overlay final prev);
    };
}
