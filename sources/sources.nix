let
  fetchGit' = base: owner: repo: ref:
    let
      url = "${base}/${owner}/${repo}";
    in
    
    with (builtins.fetchGit { inherit url ref; });
    { 
      inherit base owner repo rev outPath;
    };

  fetchGithub =
    fetchGit' "https://github.com";

  fetchGitlab =
    fetchGit' "https://gitlab.com";

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
    iwanttodie = fetchNixpkgs "master";
  };
  libs = {
    nixpkgs-mozilla = fetchGithub "mozilla" "nixpkgs-mozilla" "master";
    home-manager = fetchGithub "rycee" "home-manager" "master";
    clever = fetchGithub "cleverca22" "nixos-configs" "master";
  };
}
