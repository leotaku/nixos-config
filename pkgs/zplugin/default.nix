{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-01-23";

  src = fetchFromGitHub {
    repo = "zplugin";
    owner = "zdharma";
    rev = "d84c99199c6bb2106d6be5ddde1ba4817d5efe3f";
    sha256 = "067y57m334p90fjkjc7dlpahddvqcrk6xzm91d5mcbfzml4ql1qf";
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
