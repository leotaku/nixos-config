#!/usr/bin/env bash
dir="$(realpath $(dirname $0))"
cd $dir

rm -r links/*

function link() {
    store_path="$1"
    link_path="links/$2"

    mkdir -p "$link_path"
    rm -r "$link_path"
    ln -s "$store_path" "$link_path"
    nix-store --add-root "$link_path" --indirect -r "$link_path" &>/dev/null
}


link "/nix/store/ajalscnhi23n7wc5sjkwzbhispkzrddy-source" "libs/clever"
link "/nix/store/wn93nm3jf4k1ljxzqpq021jfxdj8lvfj-source" "libs/home-manager"
link "/nix/store/vrxaca2sz1srvmq00q22nj4wvziz12mk-source" "libs/nixpkgs-mozilla"
link "/nix/store/zdcsifa7cr4qfywyz3k71jqf2fpv7szr-source" "nixpkgs/master"
link "/nix/store/jxfrahgls8zyfry44zsphin0myfkm1g3-source" "nixpkgs/nixos-18_09"
link "/nix/store/1yv5hf9x11kjwd5rc1pfbc3c05mszpqp-source" "nixpkgs/nixos-unstable"
link "/nix/store/jxfrahgls8zyfry44zsphin0myfkm1g3-source" "nixpkgs/rpi"
link "/nix/store/1yv5hf9x11kjwd5rc1pfbc3c05mszpqp-source" "nixpkgs/system"
link "/nix/store/5jc2ca2kvy96bshfngmwcn3wfi9wphsw-source" "nixpkgs/unstable-aarch64"
