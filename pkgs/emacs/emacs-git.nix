{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "3b5f8ab0d06f6c39aaa716b6279c2ceb4bfc5b14"; # master
    sha256 = "1p54v88ls8a2rz0b0s99dpfich2jg03y1j5ls5vqv8binbnirrwn";
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
