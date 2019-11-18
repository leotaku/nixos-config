let
  sources = import ./sources/nix/sources.nix;
  # TODO: build for other nixpkgs versions
  pkgs = import nixos-unstable {
    overlays = [ (import ./pkgs/default.nix) ];
  };
  pkgs-stable = import nixos-19_09 {
    overlays = [ (import ./pkgs/default.nix) ];
  };
  inherit (sources) nixos-19_09 nixos-unstable;

  filter = file: a @ { config, pkgs, lib, ... }:
    builtins.removeAttrs (import file a) [ "deployment" ];
in
{
  x86_64-linux = pkgs.recurseIntoAttrs (
    # Build packages defined in overlays
    (import ./pkgs/default.nix pkgs pkgs) // {
      # Build my Raspberry PI 3 system
      rpi = (import "${pkgs-stable.path}/nixos" {
        configuration = filter ./deployments/rpi.nix;
      }).system;
    }
  );
}

