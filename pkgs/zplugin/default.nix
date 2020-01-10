{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-01-08";

  src = fetchFromGitHub {
    repo = "zplugin";
    owner = "zdharma";
    rev = "99a1d9595e71f9dd430cb9921160db443b7eefaf";
    sha256 = "17zl7kav96437q92ld78qk3zn40pn00wnh5jizir1c75h3vzpyrw";
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
