let
  flake = builtins.getFlake (builtins.toString ./.);
  pkgs = import flake.inputs.nixpkgs {
    overlays = [ (import ./pkgs/default.nix) ];
  };
in {
  x86_64-linux = pkgs.recurseIntoAttrs (
    # Build packages defined in overlays
    import ./pkgs/default.nix pkgs pkgs
  );
}
