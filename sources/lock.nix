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
libs.clever = (fetchGit' "https://github.com" "cleverca22" "nixos-configs" "738e551c261fce79869c92723ded657b0346e0e1");
libs.home-manager = (fetchGit' "https://github.com" "rycee" "home-manager" "601619660de5a86ae6eb95936b7bffc03227dbc2");
libs.nixpkgs-mozilla = (fetchGit' "https://github.com" "mozilla" "nixpkgs-mozilla" "507efc7f62427ded829b770a06dd0e30db0a24fe");
libs.simple-nixos-mailserver = (fetchGit' "https://gitlab.com" "simple-nixos-mailserver" "nixos-mailserver" "c2ca4d1bb05a5c3886b433dc10b2c4d55bfa1f29");
nixpkgs.master = (fetchGit' "https://github.com" "NixOS" "nixpkgs" "5f106e8aae930c7f48a50cf20c1c92d80ca733c8");
nixpkgs.nixos-18_09 = (fetchGit' "https://github.com" "NixOS" "nixpkgs-channels" "749a3a0d00b5d4cb3f039ea53e7d5efc23c296a2");
nixpkgs.nixos-18_09-small = (fetchGit' "https://github.com" "NixOS" "nixpkgs-channels" "119a93190a86794179e13ec38d51140e953a8ca9");
nixpkgs.nixos-unstable = (fetchGit' "https://github.com" "NixOS" "nixpkgs-channels" "bc41317e24317b0f506287f2d5bab00140b9b50e");
nixpkgs.system = (fetchGit' "https://github.com" "NixOS" "nixpkgs-channels" "bc41317e24317b0f506287f2d5bab00140b9b50e");
tools.direnv = (fetchGit' "https://github.com" "direnv" "direnv" "08a64e8a1a4a786b77ec4e344c111df0fb4394cf");
}

