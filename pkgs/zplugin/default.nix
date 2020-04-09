{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-04-08";

  src = fetchFromGitHub {
    repo = "zinit";
    owner = "zdharma";
    rev = "1553e5044369b57fa0c3230f9607610e4a2c0bf5";
    sha256 = "1j18cs2vrrcdy2010mp91wsq10n2kglfci55nfc3kp0pqmbsc916";
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
