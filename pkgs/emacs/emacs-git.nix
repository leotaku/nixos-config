{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "208102fa470e3417320062cdb48a9967d80bf092"; # master
    sha256 = "0bzfds13ciwii2ypklk1w37g22d7q447nnf1qz6q0swkkz86w4wz";
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
