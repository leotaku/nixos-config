{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "b44abacc8cfee02de45773424dd7b18d8794a6c3"; # master
    sha256 = "008agkj6d1mrw4mjjqddbkq9mkxjk18hmk440qr2gdwjbnjf6vry";
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
