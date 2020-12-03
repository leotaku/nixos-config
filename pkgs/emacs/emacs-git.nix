{ emacs, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "21104e6808a4496afb8163d92c6fb4d59e3010b7"; # feature/native-comp
    sha256 = "1dm472gwqxhg15jvcw8w45fjxxid8ddhysdh9cfxwca4j8r032x8";
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
