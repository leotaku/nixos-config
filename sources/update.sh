#!/usr/bin/env bash
dir="$(dirname $(realpath $0))"
linkdir="${dir}/links"
cd "$dir"

# fetch
echo -e "\033[2;42m\033[2;30mfetching:\033[0m"
niv update || exit 1

# relink
echo -e "\033[2;43m\033[2;30mlinking:\033[0m"
"${dir}/link.sh" || exit 1
