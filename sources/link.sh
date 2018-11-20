#!/usr/bin/env bash
dir="$(realpath $(dirname $0))"
cd $dir

path="$(nix-build . -A nixpkgs.system)"
echo $path

rm ./mutable/system
ln -s "$path" ./mutable/system

path="$(nix-build . -A libs.home-manager)"
echo $path

rm ./mutable/home-manager
ln -s "$path" ./mutable/home-manager
