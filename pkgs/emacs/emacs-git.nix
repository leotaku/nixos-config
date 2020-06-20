{ stdenv, emacs, harfbuzz, jansson, imagemagick, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "be5d0c0f63081b5aee5efe2fbcc5c4ace6ca9a02";
    sha256 = "1qi87b8alfjyq0fvr2v2rk0gydh4ik7lgjjz7w5zfk1fzan18y1b";
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
