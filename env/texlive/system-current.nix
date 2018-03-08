{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
texlive.combine {
  inherit (texlive) scheme-full titling;
}
