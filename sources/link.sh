#!/usr/bin/env bash
dir="$(dirname $(realpath $0))"
linkdir="${dir}/links"
if ! [[ -d "$linkdir"  ]]; then
    mkdir "$linkdir"
fi

json="$(nix-instantiate --eval --strict --json ${dir}/nix/sources.nix)"

while read key; do
    {
        nix build -f "${dir}/nix/sources.nix" "$key" --out-link "${linkdir}/${key}"\
            2>&1 | read -r output
        echo "key: $key"
        [ -n "$output" ] && echo "output: $output"
    } &
done <<< $(jq -r 'keys | .[]' <<< $json)

wait $(jobs -p)
