{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-04-20";

  src = fetchFromGitHub {
    repo = "zinit";
    owner = "zdharma";
    rev = "fbc77d998547ca546115c0fb79a17c653ab57ea1";
    sha256 = "1mpdsfg5caxli1w7dhgxiir01hdc97wqv54i3rki3fq9qrhsk2j9";
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
