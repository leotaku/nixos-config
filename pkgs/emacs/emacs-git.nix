{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "82116a5ea382cf87138d8cde3e7d770e540a7d26"; # master
    sha256 = "1wv29xgf73vrv84vwkc00aa0fhv7spw4ris4z9x2pl3v4bxb8kxa";
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
