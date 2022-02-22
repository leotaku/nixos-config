{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "17c75146a400ddd95d6e49de32ff9018a9052115"; # master
    sha256 = "1rlkb8zz8fkip09mxz65p38jpkgpwanhg186gxqcpbfwdg5mgp7p";
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
