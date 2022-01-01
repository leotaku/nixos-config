{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "1d3020908b4e4ff398c3faed9321aa4932fbaad1"; # master
    sha256 = "1b13bhlwf114m62w5sfj59667xnjav49f4ps40bm32la610y8s56";
  };
in
(emacs.override {
  srcRepo = true;
  nativeComp = true;
}).overrideAttrs (oldAttrs: rec {
  pname = "emacs-unstable";
  version = "git";
  inherit src;

  doCheck = false;
  patches = null;
})
