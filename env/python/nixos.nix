{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
python3Full.withPackages (ps: with ps; [ GitPython sh pytoml pyyaml click ])
