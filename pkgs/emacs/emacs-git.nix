{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "99638d128ee07fa35525ac47217f68dd518e9175"; # feature/native-comp
    sha256 = "17mxsi98knkwx3qjnj2gmkpbhbdhp945yw4g3sp298dzwkl9i2rb";
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
