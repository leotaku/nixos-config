#!/usr/bin/env bash
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

dir="$(realpath $(dirname $0))"
cd $dir
old="$dir/.cache"

[[ -d "in"  ]] || exit 1
[[ -d "out" ]] || mkdir out

cd in;
for file in *; do
    outfile="$dir/out/$file"

    if [[ -n "$1" ]]; then
        if [[ ! $file =~ "$1" ]]; then
            echo -e "${YELLOW}Skipping $file${NC}"
            continue
        fi
    fi

    echo -e "${GREEN}updating${NC} $file"
    (cat $outfile > $old) &>/dev/null || echo -e "${YELLOW}initializing new source${NC}"

    nix-update-source "$file" -o "$outfile" &> /dev/null
    diff $outfile $old && echo -e "${RED}no diff${NC}"
    echo ""
done
