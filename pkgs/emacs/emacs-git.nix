{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "1772d88c1fa811eee235ba9b8b7584bb000ac293"; # master
    sha256 = "05lnngjxm73339brnsazgv11hpkbbcqrg7zxdqiina6is6k802gq";
  };
in
(emacs.override {
  srcRepo = true;
  nativeComp = false;
}).overrideAttrs (oldAttrs: rec {
  pname = "emacs-unstable";
  version = "git";
  inherit src;

  doCheck = false;
  patches = null;
})
