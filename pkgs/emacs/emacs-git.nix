{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "c5c6d5cf1c886635579142d67b743421043fe5d9"; # master
    sha256 = "1sw78a7i5lrb1iswj9x9fzn2vg564sr272c4327is9l7x3xim2jy";
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
