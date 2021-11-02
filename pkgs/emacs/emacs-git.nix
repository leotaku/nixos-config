{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "493fde95bed6c65e049b8e664837397546847b37"; # master
    sha256 = "0382hc2khnyasgv223gid9c1x92mww6pqig35vh71z6r2xm70jp7";
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
