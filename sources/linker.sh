#!/usr/bin/env bash
dir="$(realpath $(dirname $0))"
cd $dir

rm -r links/*

function link() {
 attrs_path="$1"
 link_path="links/$2"
 outPath=".outPath"

 #echo nix-instantiate ./lock.nix --eval -A "$attrs_path$outPath"
 store_path=$(nix-instantiate ./lock.nix --eval -A "$attrs_path$outPath" | tr -d '"')

 mkdir -p "$link_path"
 rm -r "$link_path"
 ln -s "$store_path" "$link_path"
 nix-store --add-root "$link_path" --indirect -r "$link_path" &>/dev/null
}


link "libs.clever" "libs/clever"
link "libs.home-manager" "libs/home-manager"
link "libs.nixpkgs-mozilla" "libs/nixpkgs-mozilla"
link "libs.simple-nixos-mailserver" "libs/simple-nixos-mailserver"
link "nixpkgs.master" "nixpkgs/master"
link "nixpkgs.nixos-18_09" "nixpkgs/nixos-18_09"
link "nixpkgs.nixos-18_09-small" "nixpkgs/nixos-18_09-small"
link "nixpkgs.nixos-unstable" "nixpkgs/nixos-unstable"
link "nixpkgs.system" "nixpkgs/system"
link "tools.direnv" "tools/direnv"

