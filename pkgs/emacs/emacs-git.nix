{ stdenv, emacs, harfbuzz, jansson, imagemagick, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "963a9ffd66cb29f0370e9a4b854dddda242c54a6";
    sha256 = "1yd5jis0rj7fjhzrb2vpcb3cdg6s7fxjxxcb3xi0b5jkadgkw8gz";
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
