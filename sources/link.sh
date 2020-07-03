#!/usr/bin/env bash
dir="$(dirname $(realpath $0))"
linkdir="${dir}/links"

if [[ -d "$linkdir"  ]]; then
    rm -r "$linkdir"
fi
mkdir "$linkdir"

nix-eval() {
    nix-instantiate --json --eval -E "$1" | jq -r "$2"
}

names=$(nix-eval 'builtins.attrNames (import ./nix/sources.nix)' '.[]')

while read name; do
    if [[ "${name}" != "__functor" ]]; then
        output=$(nix-eval "(import ./nix/sources.nix).${name}.outPath" '.')
        target="${linkdir}/${name}"

        if [[ -n "${output}" ]]; then
            echo "  Package: ${name}"
            ln -s "$output" "$target"
            nix-store --add-root "$target" --indirect -r "$output"
        fi
    fi
done <<< $names
