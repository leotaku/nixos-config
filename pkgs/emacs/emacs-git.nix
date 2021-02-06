{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "a8b8d220b4fccaa812e85f9b2b3715593dc285ac"; # feature/native-comp
    sha256 = "1wr4kjqa1nlyasdzp3d4d9dgcswb0k18lnyfmyzagjjinp3m2lyb";
  };
in
(emacs.override {
  srcRepo = true;
  nativeComp = true;
}).overrideAttrs (oldAttrs: rec {
  name = "emacs-unstable-${version}";
  version = "git";
  inherit src;

  doCheck = false;
  patches = null;
})
