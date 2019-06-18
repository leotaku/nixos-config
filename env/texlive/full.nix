{ pkgs ? import <nixpkgs> { }, ... }:
with pkgs;
(texlive.combine {
  inherit (texlive) scheme-full;
  pkgFilter = pkg: lib.elem pkg.tlType [ "run" "bin" ]; # "doc" ];
}).overrideAttrs (attrs: { ignoreCollisions = false; })
