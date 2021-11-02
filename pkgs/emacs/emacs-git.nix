{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "b02a7ad2631b6ac3a95e53cb26a0aa1b1ab7e98a"; # master
    sha256 = "0z9xhxhqhb1zbmb8zglbq6yz976pw83clz61g4vkx93j7s61c69m";
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
