#!/usr/bin/env bash
dir="$(dirname $(realpath $0))"
linkdir="${dir}/links"
cd "$dir"

# functions
jq_act () {
    cat "$1" | jq -r '[[keys_unsorted, [.[]]] | transpose[] | (.[0] + ": " + .[1].rev)] | .[]'
}

# fetch
echo -e "\033[2;42m\033[2;30mfetching:\033[0m"
old="$(mktemp)"
jq_act "${dir}/nix/sources.json" > $old
niv update

# test if relinking (or force)
if [[ -z "$1" ]]; then
    diff "$old" <(jq_act ${dir}/nix/sources.json) --brief >/dev/null
    [[ "$?" == "0" ]] && exit 0
fi

# show changes
echo -e "\033[2;41m\033[2;30mchanges:\033[0m"
diff "$old" <(jq_act ${dir}/nix/sources.json) --color=auto

# relink
echo -e "\033[2;43m\033[2;30mlinking:\033[0m"
"${dir}/link.sh"

# cleanup
cleanup () {
    [[ -n "$old" ]] && rm "$old"
}
trap cleanup 0 1 2 3 6
