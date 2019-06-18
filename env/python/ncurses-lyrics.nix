{ pkgs ? import <nixpkgs> { }, ... }:
with pkgs;
python3.withPackages
(ps: with ps; [ cursebox requests requests_oauthlib bs4 pylint ])
