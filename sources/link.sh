#!/usr/bin/env bash
dir="$(dirname $(realpath $0))"
linkdir="${dir}/links"
if ! [[ -d "$linkdir"  ]]; then
    mkdir "$linkdir"
fi

names=`nix-instantiate --json --eval -E "builtins.attrNames (import ./nix/sources.nix)" | jq -r '.[]'`

while read name; do
    {
        output=`nix build -f "${dir}/nix/sources.nix" "$name" --out-link "${linkdir}/${name}"`
        echo "key: $name"
        [ -n "$output" ] && echo "output: $output"
    } &
done <<< $names

wait $(jobs -p)
exit 0
