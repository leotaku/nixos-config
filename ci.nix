let
  flake = builtins.getFlake (builtins.toString ./.);
  pkgs = flake.legacyPackages.x86_64-linux;
in {
  x86_64-linux = pkgs.recurseIntoAttrs (
    # Build packages defined in overlays
    import ./pkgs/default.nix pkgs pkgs
  );
}
