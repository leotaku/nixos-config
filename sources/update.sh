#!/usr/bin/env bash
dir="$(realpath $(dirname $0))"
linkdir="${dir}/links"
cd "$dir"

old="$(mktemp)"
cat "${dir}/nix/sources.json" > $old
niv update
diff "${dir}/nix/sources.json" "$old" --color=auto
difference="$?"
rm "$old"

if ! [[ "0" == "$difference" ]]; then
    "${dir}/link.sh"
fi
