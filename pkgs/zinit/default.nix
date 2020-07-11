{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc, lib }:

stdenv.mkDerivation rec {
  name = "zinit-${version}";
  version = "2020-07-10";

  src = fetchFromGitHub {
    repo = "zinit";
    owner = "zdharma";
    rev = "7bdee59a5460debd572c01c3a8ff8791fc75f84a";
    sha256 = "085y7i4xispd5j977i0h6gfagn25x2c6qk2sn7k9sbispc5mxnj0";
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
