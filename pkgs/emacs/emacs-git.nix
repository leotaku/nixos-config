{ stdenv, emacs, harfbuzz, jansson, imagemagick, fetchFromGitHub, ... }:

let
  src = fetchFromGitHub {
    owner = "emacs-mirror";
    repo = "emacs";
    rev = "e168bb73865f64cc67f80f8b2599c826cbf9e957";
    sha256 = "16621z5jyysmdk4b7gdckjj2b6x01wjx24wskrjqxsxxdspwmiib";
  };
in
(emacs.override {
  srcRepo = true;
}).overrideAttrs (oldAttrs: rec {
  name = "emacs-${version}";
  version = "27.git";

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
