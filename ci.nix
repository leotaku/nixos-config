let
  sources = import ./sources/nix/sources.nix;
  pkgs = import sources.nixos-unstable { };
in {
  x86_64-linux = pkgs.recurseIntoAttrs (
    # Build packages defined in overlays
    import ./pkgs/default.nix pkgs pkgs
  );
}
