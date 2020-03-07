{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-03-06";

  src = fetchFromGitHub {
    repo = "zinit";
    owner = "zdharma";
    rev = "d70b07b8f714cc82c354fcc245b58d5838ad3619";
    sha256 = "1x9nggirj84828lbakx92jm90q28r0s1i9ny902qhs032xqhhrd0";
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
