{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "8851a75ca7642ce071a23c24a81e22e443be0b05"; # master
    sha256 = "0avvsjqk4rxbz2nvisqidinmngbg7chxpz6zaf8l2xsd5jpxkhrq";
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
