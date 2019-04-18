#!/usr/bin/env bash
dir="$(dirname $(realpath $0))"
linkdir="${dir}/links"
if ! [[ -d "$linkdir"  ]]; then
    mkdir "$linkdir"
fi

json="$(nix-instantiate --eval --strict --json ${dir}/nix/sources.nix)"
keys="$(jq -r 'keys | .[]' <<< $json)"

while read key; do
    {
        nix build -f "${dir}/nix/sources.nix" "$key" --out-link "${linkdir}/${key}"\
            2>&1 | read -r output
        echo "key: $key"
        [ -n "$output" ] && echo "output: $output"
    } &
done <<< $keys

wait $(jobs -p)
exit 0
