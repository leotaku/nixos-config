{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "5e4ec4d3c944f586892e08ea4fb7715e0f6ac365"; # feature/native-comp
    sha256 = "0jfy6mf480w2841cxkvsplg6xbig42jnavrgdzmyii98qf8qxl1y";
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
