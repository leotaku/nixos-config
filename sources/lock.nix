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
libs.home-manager = (fetchGit' "https://github.com" "rycee" "home-manager" "1cdb8abf301f5c5ac99849d3754d1477b5d2b3e5");
libs.nixpkgs-mozilla = (fetchGit' "https://github.com" "mozilla" "nixpkgs-mozilla" "507efc7f62427ded829b770a06dd0e30db0a24fe");
libs.simple-nixos-mailserver = (fetchGit' "https://gitlab.com" "simple-nixos-mailserver" "nixos-mailserver" "2c59de8dcba6ec7ca386391cb139b06e40450bdd");
nixpkgs.master = (fetchGit' "https://github.com" "NixOS" "nixpkgs" "929cc78363e6878e044556bd291382eab37bcbed");
nixpkgs.nixos-18_09 = (fetchGit' "https://github.com" "NixOS" "nixpkgs-channels" "5225d4bf0193b51cfb1a200faa4ae50958f98c62");
nixpkgs.nixos-18_09-small = (fetchGit' "https://github.com" "NixOS" "nixpkgs-channels" "5225d4bf0193b51cfb1a200faa4ae50958f98c62");
nixpkgs.nixos-unstable = (fetchGit' "https://github.com" "NixOS" "nixpkgs-channels" "64825dfd26ace38ffa2c0de971a5fafb87fdfd30");
nixpkgs.system = (fetchGit' "https://github.com" "NixOS" "nixpkgs-channels" "64825dfd26ace38ffa2c0de971a5fafb87fdfd30");
tools.direnv = (fetchGit' "https://github.com" "direnv" "direnv" "0dcb17f5a0b77222a76785dd427f29c1d27d3d81");
}

