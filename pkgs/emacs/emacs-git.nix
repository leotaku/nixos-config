{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "15c20cb4fe9a43a96fc0d80c442741b8d2e21bc7"; # master
    sha256 = "1vkjlzjqf5wf3wwb088sz0c85h66v0by6fx0lqvwkqnizx55x2g4";
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
