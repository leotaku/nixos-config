{ stdenv, fetchFromGitHub, zsh, gnumake, ncurses, autoconf, gcc, lib }:

stdenv.mkDerivation rec {
  name = "zinit-${version}";
  version = "2020-05-15";

  src = fetchFromGitHub {
    repo = "zinit";
    owner = "zdharma";
    rev = "98c120db6412c19d9a24ed2c0a3515b22c7ac323";
    sha256 = "014wid2zgwx3sa8cwcllkci411s3yh7p6qrk2cn97r8iz7zg2hx8";
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
