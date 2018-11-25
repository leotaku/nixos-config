let
  lib = import ./lib.nix;

  gitString = { path, ... }:
  let
    concat = builtins.concatStringsSep;
  in
''link "${concat "." path}" "${concat "/" path}"'';

  makeSources = attrs:
      (builtins.foldl' (acc: v: 
''${acc}
${gitString v}'') "" (lib.mapAttrsToList 1 attrs));

  writeLinker = attrs:
  let
    sourceStr = makeSources attrs;
  in
''
#!/usr/bin/env bash
dir="$(realpath $(dirname $0))"
cd $dir

rm -r links/*

function link() {
    attrs_path="$1"
    link_path="links/$2"
    outPath=".outPath"

    #echo nix-instantiate ./lock.nix --eval -A "$attrs_path$outPath"
    store_path=$(nix-instantiate ./lock.nix --eval -A "$attrs_path$outPath" | tr -d '"')

    mkdir -p "$link_path"
    rm -r "$link_path"
    ln -s "$store_path" "$link_path"
    nix-store --add-root "$link_path" --indirect -r "$link_path" &>/dev/null
}

${sourceStr}
'';

in
  writeLinker (import ./lock.nix)
