{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "c5af19cba5924de89a38e7a177c07f42fd3cd543"; # master
    sha256 = "0n16fnfgkgqcgvfm7fxs5vir6ag0abbbwywr8ybvsydy06v624nk";
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
