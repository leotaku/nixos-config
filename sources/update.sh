#!/usr/bin/env bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

dir="$(realpath $(dirname $0))"
file="${dir}/.tmpfile"
cd $dir

function build () {
    contents="$(nix-instantiate builder.nix --eval)"
    contents="${contents%\"}"
    contents="${contents#\"}"
    contents="${contents//\\\"/\"}"
    contents="${contents//\\\\/}"
    
    if [[ -n "$contents" ]]; then
        echo -e $contents > $file
        diff lock.nix "$file" --color=auto && echo -e "${RED}no updates${NC}"
        cat "$file" > lock.nix
    fi
}

function buildLinker () {
    contents="$(nix-instantiate linker.nix --eval)"
    contents="${contents%\"}"
    contents="${contents#\"}"
    contents="${contents//\\\"/\"}"
    contents="${contents//\\\\/}"

    if [[ -n "$contents" ]]; then
        echo -e $contents > $file
        diff linker.sh "$file" &>/dev/null && echo -e "${YELLOW}linker not updated" || echo -e "${YELLOW}updated linker${NC}"
        diff linker.sh "$file" --color=auto
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

rm "$file"
