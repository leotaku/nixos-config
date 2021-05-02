{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "30d974bf5c02a1367291fbb6fa17a182bb7974b7";
    sha256 = "171jxmii1f1syqkz9sccx2f70d67g37gdvlnjrsgpd5s9s2byl2l";
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
