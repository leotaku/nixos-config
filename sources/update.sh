#!/usr/bin/env bash
dir="$(dirname $(realpath $0))"
linkdir="${dir}/links"
cd "$dir"

jq_act () {
    #cat "$1" | jq '[[keys_unsorted, [.[]]] | transpose[] | {key: .[0], value: .[1].rev}] | from_entries'
    cat "$1" | jq -r '[[keys_unsorted, [.[]]] | transpose[] | (.[0] + ": " + .[1].rev)] | .[]'
}

echo -e "\033[2;42m\033[2;30mfetching:\033[0m"
old="$(mktemp)"
jq_act "${dir}/nix/sources.json" > $old
niv update
diff "$old" <(jq_act ${dir}/nix/sources.json) --brief >/dev/null
difference="$?"

if ! [[ "0" == "$difference" ]]; then
    echo -e "\033[2;41m\033[2;30mchanges:\033[0m"
    diff "$old" <(jq_act ${dir}/nix/sources.json) --color=auto
    echo -e "\033[2;43m\033[2;30mlinking:\033[0m"
    "${dir}/link.sh"
fi

rm "$old"
