{
  description = "Leo Gaskin's overlays and personal systems";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable-small";
      flake = true;
    };
    emacs = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      flake = true;
    };
  };

  outputs = { self, nixpkgs, emacs, ... }:
    let
      forAllSystems = f:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed
        (system: f (prevFor system));
      prevFor = system:
        import nixpkgs {
          config = {
            allowAliases = false;
            allowUnfree = true;
          };
          inherit system;
        };
      mod = {
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
          overlays = [ self.overlays.default emacs.overlays.default ];
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
      overlays.default = import ./pkgs/default.nix;

      # Package set with overlay
      legacyPackages = forAllSystems (prev:
        prev.extend (prev.lib.composeManyExtensions mod.nixpkgs.overlays));
    };
}
