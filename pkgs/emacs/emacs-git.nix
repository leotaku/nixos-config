{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "040c03cae2db361d2e014a52d969a6b0ebc48f1c"; # master
    sha256 = "1lswwrs2vqgj98cnf646az48ph811bs1n8gj253kbjflr92wl11p";
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
