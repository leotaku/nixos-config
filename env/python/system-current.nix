{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
python3.withPackages (ps: with ps; [ numpy pandas toolz matplotlib pylint jupyter notebook ])
