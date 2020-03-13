{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-03-13";

  src = fetchFromGitHub {
    repo = "zinit";
    owner = "zdharma";
    rev = "e4101367e4cba64432f2e26e934501aeecbb7bd7";
    sha256 = "1im42ildr23hfzjz4l2nsp8vq7pp3px1n4b5xgx2rz5a8lif54wa";
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
