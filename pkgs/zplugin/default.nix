{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-04-03";

  src = fetchFromGitHub {
    repo = "zinit";
    owner = "zdharma";
    rev = "01ac879bcb9f13bb3a64ba7fd2873aace8a2afcf";
    sha256 = "1cmjxqd0971pflnycj0c3skgr6fwnsf0mn0zhvvw2p6czv8a27v8";
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
