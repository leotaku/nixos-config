let
  lib = import ./lib.nix;
  pkgs = import <nixpkgs> {};

  gitString = { owner, repo, rev, path, ... }:
    ''${builtins.concatStringsSep "." path} = (fetchGithub "${owner}" "${repo}" "${rev}");'';

  makeSources = attrs:
      (builtins.foldl' (acc: v: 
''${acc}
${gitString v}'') "" (lib.mapAttrsToList 1 attrs));

  writeLock = attrs:
  let
    sourceStr = makeSources attrs;
  in
  pkgs.writeText "sources"
''
let
fetchGithub = owner: repo: ref:
    let
      githubBase = "github.com";
      url = "https://" + githubBase + "/" + owner + "/" + repo;
    in
      builtins.fetchGit { inherit url ref; };
in
{${sourceStr}
}
'';

in
  writeLock (import ./sources.nix)
