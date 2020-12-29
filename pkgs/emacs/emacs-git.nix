{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "3f00d666e9674ba18f1ded490a27ac2868a32a88"; # feature/native-comp
    sha256 = "0vg6pabwzmcvlsdg2qam8aixarj2lajx6f60j0rgd80ijx3giycm";
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
