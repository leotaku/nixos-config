{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "39b3bcd324c4519ae3b204a31ab1a385b8ba9574"; # feature/native-comp
    sha256 = "1562qxyfz8wwqhqdd7xjwa9s4wpypjg7nwzw6pfy1qskwkf2l7xa";
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
