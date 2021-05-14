{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "5784b421ee41632f67a517add8806d13cc7bfb96"; # master
    sha256 = "0gg93kql797vlrd04xpwzpgrcr6wjfxhwfwn85231i8r56gjxaly";
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
