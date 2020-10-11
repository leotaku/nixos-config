#!/usr/bin/env sh
instantiate() {
    nix-instantiate \
        --eval ./pure-inputs.nix \
        -A nixpkgs.outPath
}

TARGET="/etc/nixos/links/nixpkgs"
WORKING="$(dirname $(realpath $0))"
cd "$WORKING"
STORE_PATH="$(instantiate | tr -d '"')"

mkdir -p "$(dirname $TARGET)"
rm "$TARGET" 2>/dev/null || true
ln -s "$STORE_PATH" "$TARGET"
