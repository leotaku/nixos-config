{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-01-29";

  src = fetchFromGitHub {
    repo = "zplugin";
    owner = "zdharma";
    rev = "5e0abb7dce5da816a674f0baff4829399bb6cc00";
    sha256 = "02833nl5431p5xd441f0m41nqvspl30yblg29cjh8q87cs6sv4fj";
  };

  buildInputs = [ zsh gnumake ncurses autoconf gcc ];

  configurePhase = ''
    cd zmodules
    ./configure --without-tcsetpgrp
  '';

  installPhase = ''
    cd ..
    cp -r . $out
  '';
}
