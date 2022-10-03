{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "f97993ee667f9be7589825f3a4fbc095d6944ec6"; # master
    sha256 = "14rd62svsryga9pgngc62jvj4gij4gdhbq4dxw8b2ypwd1jvp2x3";
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
