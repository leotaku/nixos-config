#!/usr/bin/env bash
dir="$(realpath $(dirname $0))"
cd $dir

function link() {
    pkg="$1"
    link_path="mutable/$2"

    store_path="$(nix-build . --no-out-link -A $pkg)"
    echo $store_path
    
    rm "$link_path"
    ln -s "$store_path" "$link_path"
    nix-store --add-root "$link_path" --indirect -r "$link_path" &>/dev/null
}

link nixpkgs.system "system"
link libs.home-manager "home-manager"
