{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc, lib }:

stdenv.mkDerivation rec {
  name = "zinit-${version}";
  version = "2020-06-20";

  src = fetchFromGitHub {
    repo = "zinit";
    owner = "zdharma";
    rev = "e53c6878b96161a2fea4c94291019ffbe32bf3d2";
    sha256 = "0sdq9pvdgimfw0j068zmgfg0px8jxsyziqc5c4ls48jdb3r2aygz";
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
