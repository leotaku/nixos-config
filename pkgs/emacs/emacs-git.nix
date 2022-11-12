{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "0aea7da80b9933bc6dc52f0e573b5dfb6826dc07"; # master
    sha256 = "04c0bx6w7ghiqr6fvm21hdrl19750rmci8wbz1i5vshfrhirbymn";
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
