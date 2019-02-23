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
{
libs.clever = (fetchGit' "https://github.com" "cleverca22" "nixos-configs" "a37fddeb4e3a105bb24971111a8a7aeead696951");
libs.home-manager = (fetchGit' "https://github.com" "rycee" "home-manager" "74811679b7f102a7e379e1f0f4160cc3c0643de6");
libs.nixpkgs-mozilla = (fetchGit' "https://github.com" "mozilla" "nixpkgs-mozilla" "e37160aaf4de5c4968378e7ce6fe5212f4be239f");
libs.simple-nixos-mailserver = (fetchGit' "https://gitlab.com" "simple-nixos-mailserver" "nixos-mailserver" "2c59de8dcba6ec7ca386391cb139b06e40450bdd");
nixpkgs.master = (fetchGit' "https://github.com" "NixOS" "nixpkgs" "7b25f9c8338446762ab132db6eb2866ddb7fc62d");
nixpkgs.nixos-18_09 = (fetchGit' "https://github.com" "NixOS" "nixpkgs-channels" "9bd45dddf8171e2fd4288d684f4f70a2025ded19");
nixpkgs.nixos-18_09-small = (fetchGit' "https://github.com" "NixOS" "nixpkgs-channels" "ea0820818a7bfd9086d021122c6e23f24d166be7");
nixpkgs.nixos-unstable = (fetchGit' "https://github.com" "NixOS" "nixpkgs-channels" "36f316007494c388df1fec434c1e658542e3c3cc");
nixpkgs.system = (fetchGit' "https://github.com" "NixOS" "nixpkgs-channels" "36f316007494c388df1fec434c1e658542e3c3cc");
tools.direnv = (fetchGit' "https://github.com" "direnv" "direnv" "7e010b13a06b050085694ff36647be376e228a4e");
}

