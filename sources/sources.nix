let
  fetchGit = base: owner: repo: ref:
    let
      url = "${base}/${owner}/${repo}";
    in
    { 
      inherit owner repo;
      rev = (builtins.fetchGit { inherit url ref; }).rev;
      outPath = (builtins.fetchGit { inherit url ref; }).outPath;
    };

  fetchGithub =
    fetchGit "https://github.com";

  fetchChannel =
    fetchGithub "NixOS" "nixpkgs-channels";

  fetchNixpkgs =
    fetchGithub "NixOS" "nixpkgs";

in
rec {
  nixpkgs = {
    nixos-unstable = fetchChannel "nixos-unstable"; 
    nixos-18_09 = fetchChannel "nixos-18.09";
    unstable-aarch64 = fetchNixpkgs "unstable-aarch64";
    master = fetchNixpkgs "master";
    
    system = nixpkgs.nixos-unstable;
    rpi = nixpkgs.nixos-18_09;
  };
  libs = {
    nixpkgs-mozilla = fetchGithub "mozilla" "nixpkgs-mozilla" "master";
    home-manager = fetchGithub "rycee" "home-manager" "master";
    clever = fetchGithub "cleverca22" "nixos-configs" "master";
  };
}
