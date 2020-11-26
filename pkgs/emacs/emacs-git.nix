{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "7a8370ed0f1b1d62657e385789ee2f81c5607ec5"; # feature/native-comp
    sha256 = "15w4hnvkavhz464c9n572w4icb06503xn44kpmg7wz8qnzng38k3";
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
