{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2019-12-06";

  src = fetchFromGitHub {
    repo = "zplugin";
    owner = "zdharma";
    rev = "e28cab88c94232350d46bc1d6b52cd43830e24b6";
    sha256 = "0kxpqnl6hllhp0vq5s57r8achrkprns8yxjfy4xipjicsmaf7kk2";
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
