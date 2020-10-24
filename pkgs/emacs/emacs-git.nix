{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "d5791ba5feeb5500433ca43506dda13c7c67ce14";
    sha256 = "0j2y3lp6px69w43gi5dqxkslq26zi3d0i54n44gl04apy7mgshxq";
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
