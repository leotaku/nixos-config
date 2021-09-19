{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "b6bff3ba7971daad737690d88a3921f1dd190476"; # master
    sha256 = "10lb05fm13ab3v0jw8xjz9lfwc1081kp5lv7y2frfjh1sav45n8v";
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
