let
  # Use Flakes when it is available
  hasFlakes = builtins.hasAttr "getFlake" builtins;
  compat = src: (import ./compat.nix { inherit src; }).defaultNix;
  kind = if hasFlakes then builtins.getFlake else compat;
in (kind (builtins.toString ./..)).inputs
