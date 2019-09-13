{ stdenv, fetchFromGitHub, pkgs }:

let
  log4c = stdenv.mkDerivation rec {
    name = "log4c";
    version = "1.2.4";
    src = builtins.fetchTarball {
      url =
        "https://sourceforge.net/projects/log4c/files/log4c/${version}/log4c-${version}.tar.gz";
    };
    configurePhase = ''
      ./configure --prefix=$out
      echo "all:" > ./examples/Makefile
      echo "install:" >> ./examples/Makefile
    '';
    buildPhase = ''
      make
    '';
    installPhase = ''
      mkdir $out; make install
    '';

    doCheck = false;
  };

in stdenv.mkDerivation rec {
  name = "tizonia";
  version = "master";

  src = fetchFromGitHub {
    repo = "tizonia-openmax-il";
    owner = "tizonia";
    rev = "master";
    sha256 = "12bp89c9ibh8mgsrdz9fcrb3d1sx3aqjsdq64pjf8d62sf5a8k36";
  };

  propagatedBuildInputs = with pkgs;
    with pkgs.python27Packages; [
      youtube-dl
      gmusicapi
      libspotify
      pafy
      dbus
      mopidy-soundcloud
    ];
    
  buildInputs = with pkgs; [
    autoconf
    automake
    pkg-config
    libtool
    bash
    getopt
    autogen
    log4c
    check
    boost
  ];

  configurePhase = ''
    export TIZONIA_REPO_DIR=$(pwd) # (e.g. /home/user/tizonia-openmax-il)
    export TIZONIA_INSTALL_DIR=$(pwd)/build # (e.g. /usr or /home/user/temp)
    export PATH=$TIZONIA_REPO_DIR/tools:$PATH

    release=(
      --prefix=$TIZONIA_INSTALL_DIR \
      --with-bashcompletiondir=$TIZONIA_INSTALL_DIR/share/bash-completion/completions \
      --with-zshcompletiondir=$TIZONIA_INSTALL_DIR/share/zsh/site-functions \
    )
    autoreconf -ifs
    ./configure
  '';
}
