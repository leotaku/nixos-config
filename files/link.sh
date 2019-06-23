#!/usr/bin/env bash

maybe_link() {
    file_or_dir="$1"
    target_file="$2"
    contents="$3"

    if [[ -e "${target_file}" ]]; then
        read -n 1 -r -p "$(basename $target_file): file exists, relink? (y/N)"
        if [[ $REPLY =~ ^[yY]$ ]]; then
            link_file_or_dir "$file_or_dir" "$target_file" "$is_dir"
        fi
    fi
    
}

link_file_or_dir() {
    file_or_dir="$1"
    target_file="$2"
    contents="$3"
    file=""
    
    if [[ -n "$contents" ]]; then
        echo "$(basename $target_file): which file to link?"
        read -r -p "$(basename $target_file): $file_or_dir/"
        file="$file_or_dir/$REPLY"
    else
        file="$file_or_dir"
    fi
    
    if [[ -n "$file" ]]; then
        echo "$(basename $target_file): linking $file to $target_file"
        mv "$target_file" "$(dirname $target_file)/$(basename $target_file).back.o$RANDOM"
        ln -s "$file" "$target_file"
    fi
}

maybe_link $HOME/nixos-config /etc/nixos/nixos-config 1
DIR=/etc/nixos/nixos-config
maybe_link $DIR/files/config.nix $HOME/.config/nixpkgs/config.nix
maybe_link $DIR/files/overlays.nix $HOME/.config/nixpkgs/overlays.nix
maybe_link $DIR/home-manager $HOME/.config/nixpkgs/home.nix 1
maybe_link $DIR/files/nix-defexpr $HOME/.nix-defexpr

echo ""
echo "You will also have to run 'sudo nix-channel --update'"
echo "Otherwise the nix 'program not found' functionality won't work"
