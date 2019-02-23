let
  lib = import ./lib.nix;

  gitString = { base, owner, repo, rev, path, ... }:
    ''${builtins.concatStringsSep "." path} = (fetchGit' "${base}" "${owner}" "${repo}" "${rev}");'';

  makeSources = attrs:
      (builtins.foldl' (acc: v: 
''${acc}
${gitString v}'') "" (lib.mapAttrsToList 1 attrs));

  writeLock = attrs:
  let
    sourceStr = makeSources attrs;
  in
''
let
fetchGit' = base: owner: repo: ref:
    let
      toPath = str: assert builtins.substring 0 1 str == "/"; /. + builtins.substring 1 (-1) (builtins.unsafeDiscardStringContext str);

      url = base + "/" + owner + "/" + repo;
    in
      with builtins.fetchGit { inherit url ref; };
      {
        inherit rev shortRev revCount outPath;
        path = toPath outPath;
      };
in
{${sourceStr}
}
'';

in
  writeLock (import ./sources.nix)
