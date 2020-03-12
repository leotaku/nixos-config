{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-03-06";

  src = fetchFromGitHub {
    repo = "zinit";
    owner = "zdharma";
    rev = "f811bf36f18f243376ebf13bfc73431708a1b71b";
    sha256 = "0cbn8sswfjzp4pqg7hlqbzamr784k8yrp11gj4vg8r18cqdl80cx";
  };

  buildInputs = [ zsh gnumake ncurses autoconf gcc ];

  configurePhase = ''
    cd zmodules
    ./configure --without-tcsetpgrp --disable-gdbm
    make
    echo 0 > RECOMPILE_REQUEST
    echo 1 > COMPILED_AT
  '';

  installPhase = ''
    cd ..
    cp -r . $out
  '';
}
