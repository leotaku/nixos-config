{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "d932e256a497d80de9dbcea6a8e019d2cb063429"; # master
    sha256 = "00nnpsm7abyz2snysz74xf43xn8kkicfks0r64plw8q1blnd55vq";
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
