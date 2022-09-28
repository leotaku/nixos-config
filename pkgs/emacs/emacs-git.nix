{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "e638aaf6e82aa9eeb5e5723b995d3295b53fa6c9"; # master
    sha256 = "0g32hx5kc0q5dbnd8gnpjm2y93iw9185crpqlhwc748y19vdkwf9";
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
