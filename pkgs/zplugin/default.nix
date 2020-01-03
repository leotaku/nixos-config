{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2019-12-31";

  src = fetchFromGitHub {
    repo = "zplugin";
    owner = "zdharma";
    rev = "c793069c3e38c694cf82c66ab309aa4f1476a934";
    sha256 = "15klv8q7s6h8lh9p3brfqckj37znvzrcg1wh5ansza62g7q5j00n";
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
