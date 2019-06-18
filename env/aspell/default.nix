{ pkgs ? import <nixpkgs> { }, ... }:
with pkgs;
aspellWithDicts (a: pkgs.lib.mapAttrsToList (n: v: v) a)
