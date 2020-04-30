{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-04-21";

  src = fetchFromGitHub {
    repo = "zinit";
    owner = "zdharma";
    rev = "ff12246fb49b6a3e1ae274e5fb9b0508ab892f75";
    sha256 = "0k5r7nvfjdgf29f6afw1wqgjavd0fs7rjzqkr0bgapylzaj9wwvw";
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
