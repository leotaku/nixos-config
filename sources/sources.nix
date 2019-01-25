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
    #nixos-unstable-small = fetchChannel "nixos-unstable-small"; 
    nixos-18_09 = fetchChannel "nixos-18.09";
    nixos-18_09-small = fetchChannel "nixos-18.09-small";
    #nixos-18_09-upstream = fetchNixpkgs "release-18.09";
    #nixos-18_03 = fetchNixpkgs "release-18.03";
    #nixos-18_03-small = fetchChannel "nixos-18.03-small";
    #unstable-aarch64 = fetchNixpkgs "unstable-aarch64";
    master = fetchNixpkgs "master";
    
    system = nixpkgs.nixos-unstable;
  };
  libs = {
    nixpkgs-mozilla = fetchGithub "mozilla" "nixpkgs-mozilla" "master";
    home-manager = fetchGithub "rycee" "home-manager" "master";
    clever = fetchGithub "cleverca22" "nixos-configs" "master";
    simple-nixos-mailserver = fetchGitlab "simple-nixos-mailserver" "nixos-mailserver" "master";
  };
  tools = {
    direnv = fetchGithub "direnv" "direnv" "master";
  };
}
