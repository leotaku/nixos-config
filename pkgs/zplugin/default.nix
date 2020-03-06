{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-03-03";

  src = fetchFromGitHub {
    repo = "zplugin";
    owner = "zdharma";
    rev = "81a676304ff78b0e3e108c4c2524a676827aa759";
    sha256 = "19fvi5viil48p9hy85jr4js2h9lgpxrc0zf0shh0rkhb60rc6w5b";
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
