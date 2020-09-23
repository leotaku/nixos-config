import-pkgs:
let
  # Setup JSON and Nixpkgs
  json = builtins.fromJSON (builtins.readFile ../flake.lock);
  pkgs = if import-pkgs == null then impure-pkgs else import-pkgs;
  impure-pkgs = with json.nodes.nixpkgs.locked;
    import (builtins.fetchTarball (builtins.trace "impure nixpkgs" {
      url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
      sha256 = narHash;
    })) { };
  # Define fixed-output derivations using Nixpkgs
  nodes = with pkgs;
    lib.filterAttrs
    (_: node: lib.hasAttr "locked" node && node.locked.type == "github")
    json.nodes;
  wrap = with pkgs;
    lib.mapAttrs (_: node:
      fetchFromGitHub {
        inherit (node.locked) repo owner rev;
        sha256 = node.locked.narHash;
      });
in wrap nodes
