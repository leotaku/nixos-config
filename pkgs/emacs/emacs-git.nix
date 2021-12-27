{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "8df3a71c526c28b17926f7b56860f9798ab6d933"; # master
    sha256 = "0gdahmgcv5sv88gh5fcyrkp2agdr7k6p56zsrw26sz2gp8gavf97";
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
