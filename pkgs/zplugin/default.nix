{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc }:

stdenv.mkDerivation rec {
  name = "zplugin-${version}";
  version = "2020-02-13";

  src = fetchFromGitHub {
    repo = "zplugin";
    owner = "zdharma";
    rev = "79c689f52d55f1f88409045bc9866cb8729eb5f8";
    sha256 = "1lnkk3wq7lpv0qi3fy5v4j2nfqk6drqw7nnfzwwcq5hyrs1rvhys";
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
