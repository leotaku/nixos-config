{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "d8f392bccd46cdb238ec96964f220ffb9d81cc44"; # master
    sha256 = "0z085ysp10bnwzxjfdjlgjxy2pz3mwxfibvpqn3xy1xc8ik4jrmv";
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
