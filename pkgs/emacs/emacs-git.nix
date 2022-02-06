{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "b4f1ceaf241239b8fc7ad1e91af62f4e425bda8a"; # master
    sha256 = "1dhhayl3k5qkvysg00bvdh79mkbc66cmvmi1qwdxm0h531cb8irq";
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
