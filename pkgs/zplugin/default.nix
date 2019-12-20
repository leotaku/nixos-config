{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2019-12-20";

  src = fetchFromGitHub {
    repo = "zplugin";
    owner = "zdharma";
    rev = "dbd791ea9dc585114c57fab2063fbd6bd6617891";
    sha256 = "1dhfprkhfmwsbkz1wh4fzqrk8q3c4x2cnwm8y35y7yij7mhd8k18";
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
