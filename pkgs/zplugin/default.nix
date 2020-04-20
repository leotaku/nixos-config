{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-04-19";

  src = fetchFromGitHub {
    repo = "zinit";
    owner = "zdharma";
    rev = "ec3ba307d85bd5f64cd0b28ce725449513691132";
    sha256 = "18z376c70f8myf6jnshyi8qkfhfzdha9sfds9fyyp0jqb9jgay39";
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
