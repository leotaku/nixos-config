#!/usr/bin/env bash
dir="$(dirname $(realpath $0))"
linkdir="${dir}/links"
if ! [[ -d "$linkdir"  ]]; then
    mkdir "$linkdir"
fi

json="$(nix-instantiate --eval --strict --json ${dir}/nix/sources.nix)"

jq -r 'keys | .[]' <<< $json |\
while read key; do
    val="$(jq -r --arg k $key '.[$k]' <<< $json)"
    echo "key: $key"
    echo "val: $val"
    nix-store --add-root "${linkdir}/${key}" --indirect -r "$val" >/dev/null
done
