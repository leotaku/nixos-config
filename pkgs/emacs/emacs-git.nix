{ stdenv, emacs, harfbuzz, jansson, imagemagick, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "44298ea6aa006ed227e539b02279bd3fc11fd2a6";
    sha256 = "1czjbnajadn4ri0q2fm7730mcczbd1bqsvw8akrlfl5ldbmwmm0r";
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
