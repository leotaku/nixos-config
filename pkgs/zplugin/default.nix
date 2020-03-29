{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-03-24";

  src = fetchFromGitHub {
    repo = "zinit";
    owner = "zdharma";
    rev = "b61706d03ecc6750976131b44df260b0ab490cbe";
    sha256 = "1p0f9jd159sw9ngh1n9ig9cfamp3z0nh1y7w8lmi773hm83fy5sb";
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
