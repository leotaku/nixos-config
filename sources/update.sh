#!/usr/bin/env bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

dir="$(realpath $(dirname $0))"
cd $dir

function build () {
    file="$(nix-build builder.nix --no-out-link)"
    if [[ -n "$file" ]]; then
        printf "${GREEN}"
        diff lock.nix "$file" && echo -e "${RED}no updates"
        printf "${NC}"
        cat "$file" > lock.nix
    fi
}

function buildLinker () {
    file="$(nix-build linker.nix --no-out-link)"
    if [[ -n "$file" ]]; then
        diff linker.sh "$file" &>/dev/null && echo -e "${YELLOW}linker not updated" || echo -e "${YELLOW}updated linker"
        printf "${GREEN}"
        diff linker.sh "$file"
        printf "${NC}"
        cat "$file" > linker.sh
        chmod u+x linker.sh
    fi
}

function relink () {
    ./linker.sh && echo -e "${BLUE}relinked sources${NC}"
}

build
buildLinker
relink
