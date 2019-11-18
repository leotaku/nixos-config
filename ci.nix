let
  sources = import ./sources/nix/sources.nix;
  # TODO: build for other nixpkgs versions
  nixos-unstable = import sources.nixos-unstable;
  pkgs = nixos-unstable {
    overlays = [ (import ./pkgs/default.nix) ];
  };
in
{
  x86_64-linux = pkgs.recurseIntoAttrs (
    # Build packages defined in overlays
    import ./pkgs/default.nix pkgs pkgs
  );
}

