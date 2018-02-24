{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
python3.withPackages (ps: with ps; [ numpy toolz matplotlib pylint jupyter notebook ])
