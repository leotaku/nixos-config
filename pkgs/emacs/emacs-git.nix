{ stdenv, emacs, harfbuzz, jansson, imagemagick, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "dceba13ce57ed0cb726e89566197f77359a38d91";
    sha256 = "1sqwxi34djfak9xrbiggscl93acq28ijmlgdwh1ywbx0v1d5c9n9";
  };
in
(emacs.override {
  srcRepo = true;
}).overrideAttrs (oldAttrs: rec {
  name = "emacs-unstable-${version}";
  version = "2019-11-24";

  inherit src;

  doCheck = false;
  patches = null;

  configureflags = oldAttrs.configureFlags ++ [
    "--with-harfbuzz"
    "--with-json"
  ];

  buildInputs = oldAttrs.buildInputs ++ [
    harfbuzz
    jansson
  ];
})
