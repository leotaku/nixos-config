{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "2dfeea8962751718168494c0560d69e678794b39"; # master
    sha256 = "1l4m4nb1m2b98w57fk6gr8zykhzrmyslzwp1214jila9dd8pdak7";
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
