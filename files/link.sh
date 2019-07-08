#!/usr/bin/env bash

maybe_link() {
    file_or_dir="$1"
    target_file="$2"
    contents="$3"

    if [[ -e "${target_file}" ]]; then
        read -n 1 -r -p "$(basename $target_file): file exists, relink? (y/N)"
        if ! [[ $REPLY =~ ^[yY]$ ]]; then
            echo ""
            return
        fi
    fi
    link_file_or_dir "$file_or_dir" "$target_file" "$contents"
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
        if [[ -e "$target_file" ]]; then
            echo "$(basename $target_file): backed up"
            mv "$target_file" "$(dirname $target_file)/$(basename $target_file).back.o$RANDOM"
        fi
        ln -s "$file" "$target_file"
    fi
}

DIR=/etc/nixos/nixos-config
if ! [[ -d "$DIR" ]]; then
    echo "Please manually link this repository to /etc/nixos/nixos-config."
    echo "Then run this script once for the root user and yourself."
    return
fi
if [[ "$USER" = "root" ]]; then
    maybe_link $DIR /etc/nixos/configuration.nix 1
    echo ""
    echo "You have linked your configuration.nix file."
    echo "Please now rebuild your system using the following command (replace the location of nixpkgs with your preffered checkout):"
    echo "sudo nixos-rebuild switch -I nixpkgs=/etc/nixos/nixos-config/sources/links/nixos-unstable -I nixos-config=/etc/nixos/configuration.nix"
    echo "After this procedure a reboot is advisable."
else
    maybe_link $DIR/files/config.nix $HOME/.config/nixpkgs/config.nix
    maybe_link $DIR/files/overlays.nix $HOME/.config/nixpkgs/overlays.nix
    maybe_link $DIR/home-manager $HOME/.config/nixpkgs/home.nix 1
    maybe_link $DIR/files/nix-defexpr $HOME/.nix-defexpr

    echo ""
    echo "You have linked your user-specific .nix files."
    echo "An installation of home-manager might still be required."
    echo "Please follow the online instructions at its repository."
    echo ""
    echo "You will also have to run 'sudo nix-channel --update'"
    echo "Otherwise the nix 'program not found' functionality won't work"
fi

