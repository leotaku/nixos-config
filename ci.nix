let
  inputs = import ./files/inputs.nix;
  pkgs = import inputs.nixpkgs {
    overlays = [ (import ./pkgs/default.nix) ];
  };
in {
  x86_64-linux = pkgs.recurseIntoAttrs (
    # Build packages defined in overlays
    import ./pkgs/default.nix pkgs pkgs
  );
}
