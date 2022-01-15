{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "791694c5fe86b8c9ab5cb593bd5e050aa185aa3a"; # master
    sha256 = "0i8c0w01ans0wcrk6pdihj4gx29zkacac2ky00lr8bjgc3cmcdwc";
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
