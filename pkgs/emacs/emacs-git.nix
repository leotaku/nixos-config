{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "e68bc86bcfcc6431c4cf1e8a75b608d76ca1d1ae"; # master
    sha256 = "1gsl0wfjz3pb3jw9arikp7994nknam6dcnrn5sr5k2nay8rm5ing";
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
