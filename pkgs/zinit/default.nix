{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc, lib }:

stdenv.mkDerivation rec {
  name = "zinit-${version}";
  version = "2020-05-20";

  src = fetchFromGitHub {
    repo = "zinit";
    owner = "zdharma";
    rev = "37c3f75b51df533afc3e9d8acf8e52611fa0c13d";
    sha256 = "1x3y6qvsh9vjkigd33jik00lq6x5x1j6n7qars4i6m3ji7c5zyvz";
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
