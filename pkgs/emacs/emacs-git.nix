{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "79b8b6ca45ad707d86244882430e275efd95cdb9"; # feature/native-comp
    sha256 = "0b5h48kja0d7l5w437jagbbyjdazh9aqgggwav0akxnl25axp121";
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
