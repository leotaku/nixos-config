{
  description = "My overlays and local system";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
      flake = true;
    };
    hercules-ci-agent = {
      url = "github:hercules-ci/hercules-ci-agent";
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
      om = { ... }: { nixpkgs.overlays = [ self.overlay ]; };
    in {
      # Systems
      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ (import ./deployments/laptop/configuration.nix) om ];
        };
        fujitsu = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ (import ./deployments/fujitsu.nix) om ];
        };
        rpi = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [ (import ./deployments/rpi.nix) ];
        };
      };

      # Custom overlay
      overlay = s: ss: (import ./pkgs s ss) // {
        hercules-ci-agent =
          self.inputs.hercules-ci-agent.packages."${ss.system}".hercules-ci-agent;
      };

      # Package set with overlay
      legacyPackages.x86_64-linux = prev // (self.overlay final prev);
    };
}
