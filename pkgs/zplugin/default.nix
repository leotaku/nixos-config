{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-05-13";

  src = fetchFromGitHub {
    repo = "zinit";
    owner = "zdharma";
    rev = "2b02f175924d94e9787e168fad646a6a65e2df4d";
    sha256 = "1cz3247jmarm83rh4xxj6qf9sjgszbd36snbnp3qsj5520s66i8q";
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
