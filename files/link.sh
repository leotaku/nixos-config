#!/usr/bin/env sh
set -e

instantiate() {
    nix-instantiate --eval \
        --expr 'builtins.getFlake (builtins.toString ./..)' \
        -A inputs.nixpkgs.outPath
}

WORKING="$(dirname "$(realpath "$0")")"
cd "$WORKING" || exit 1
STORE_PATH="$(instantiate | tr -d '"')"

nix-store --add-root "$TARGET" -r "$STORE_PATH"
