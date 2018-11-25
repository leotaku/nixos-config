let
  lib = import ./lib.nix;
  pkgs = import <nixpkgs> {};

  gitString = { owner, repo, rev, path, outPath }:
  let
    concat = builtins.concatStringsSep;
  in
''link "${outPath}" "${concat "/" path}"'';

  makeSources = attrs:
      (builtins.foldl' (acc: v: 
''${acc}
${gitString v}'') "" (lib.mapAttrsToList 1 attrs));

  writeLinker = attrs:
  let
    sourceStr = makeSources attrs;
  in
  pkgs.writeText "linker"
''
#!/usr/bin/env bash
dir="$(realpath $(dirname $0))"
cd $dir

rm -r links/*

function link() {
    store_path="$1"
    link_path="links/$2"

    mkdir -p "$link_path"
    rm -r "$link_path"
    ln -s "$store_path" "$link_path"
    nix-store --add-root "$link_path" --indirect -r "$link_path" &>/dev/null
}

${sourceStr}
'';

in
  writeLinker (import ./sources.nix)
