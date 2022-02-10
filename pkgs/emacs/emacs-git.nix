{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "f063e385216940f4a914b2978edf8dd178faa2a6"; # master
    sha256 = "03l36zkg8if3p38b127jzl1fa3ksiiq811cgp52czhvcinr5sp5j";
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
