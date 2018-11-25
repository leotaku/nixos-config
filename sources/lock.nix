let
fetchGithub = owner: repo: ref:
    let
      githubBase = "github.com";
      url = "https://" + githubBase + "/" + owner + "/" + repo;
    in
      builtins.fetchGit { inherit url ref; };
in
{
libs.clever = (fetchGithub "cleverca22" "nixos-configs" "53312d168e6f7d8fb49ed9d854ae303b0a92a99d");
libs.home-manager = (fetchGithub "rycee" "home-manager" "59448d635c7ac0b73f1517b69e5c9dea1d8a9572");
libs.nixpkgs-mozilla = (fetchGithub "mozilla" "nixpkgs-mozilla" "0d64cf67dfac2ec74b2951a4ba0141bc3e5513e8");
nixpkgs.master = (fetchGithub "NixOS" "nixpkgs" "3a393eecafb3fcd9db5ff94783ddab0c55d15860");
nixpkgs.nixos-18_09 = (fetchGithub "NixOS" "nixpkgs-channels" "5d4a1a3897e2d674522bcb3aa0026c9e32d8fd7c");
nixpkgs.nixos-unstable = (fetchGithub "NixOS" "nixpkgs-channels" "80738ed9dc0ce48d7796baed5364eef8072c794d");
nixpkgs.rpi = (fetchGithub "NixOS" "nixpkgs-channels" "5d4a1a3897e2d674522bcb3aa0026c9e32d8fd7c");
nixpkgs.system = (fetchGithub "NixOS" "nixpkgs-channels" "80738ed9dc0ce48d7796baed5364eef8072c794d");
nixpkgs.unstable-aarch64 = (fetchGithub "NixOS" "nixpkgs" "41c22102eaeb110dc69ced1c680252da5d1b3634");
}
