#!/usr/bin/env sh
set -e

instantiate() {
    nix-instantiate --eval \
        --expr 'builtins.getFlake (builtins.toString ./..)' \
        -A inputs.nixpkgs.outPath
}

TARGET="/etc/nixos/links/nixpkgs"
WORKING="$(dirname "$(realpath "$0")")"
cd "$WORKING" || exit 1
STORE_PATH="$(instantiate | tr -d '"')"

mkdir -p "$(dirname $TARGET)"
rm "$TARGET" 2>/dev/null || true
ln -s "$STORE_PATH" "$TARGET"

nix-store --add-root "$TARGET" -r "$STORE_PATH"
