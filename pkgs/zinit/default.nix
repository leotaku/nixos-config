{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc, lib }:

stdenv.mkDerivation rec {
  name = "zinit-${version}";
  version = "2020-07-15";

  src = fetchFromGitHub {
    repo = "zinit";
    owner = "zdharma";
    rev = "ed54f898d92d73a3c67c015cb09a7db0f1d78a8c";
    sha256 = "03md0ng7xnblsbhsxrvwhgbp29j5dbwpa8irhq4dbv90x09vdsyg";
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

  meta = with lib; {
    description = "Ultra-flexible and fast Zsh plugin manager";
    homepage = "https://github.com/zdharma/zinit";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
