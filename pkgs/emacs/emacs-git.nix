{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "840b9eadd6a06c939980bb8b90d8402128ea8901"; # master
    sha256 = "0yyy2klydk1md63wi8l3r2xsfbvhv3pf92xbjyz55n8za4fkxdyb";
  };
in
(emacs.override {
  srcRepo = true;
  nativeComp = false;
}).overrideAttrs (oldAttrs: rec {
  pname = "emacs-unstable";
  version = "git";
  inherit src;

  doCheck = false;
  patches = null;
})
