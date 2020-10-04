{
  description = "My overlays and local system";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable-small";
      flake = true;
    };
    nixpkgs-mozilla = {
      url = "github:mozilla/nixpkgs-mozilla/master";
      flake = false;
    };
    morph = {
      url = "github:DBCDK/morph/master";
      flake = false;
    };
    update-nix-fetchgit = {
      url = "github:expipiplus1/update-nix-fetchgit/master";
      flake = false;
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
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ (import ./deployments/laptop/configuration.nix) ];
      };

      # Custom overlay
      overlay = import ./pkgs/default.nix;

      # Package set with overlay
      legacyPackages.x86_64-linux = prev // (self.overlay final prev);
    };
}
