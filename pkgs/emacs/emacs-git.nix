{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "a6bfc3cb87e91d37e0a7b67e9c68224fb432c989"; # master
    sha256 = "165h47d1dp08r76lfkdkjj8pbcyrqzi7xayy2r2v7mj054i2b82z";
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
