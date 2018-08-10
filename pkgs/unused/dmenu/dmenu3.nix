{ stdenv, fetchgit, libX11, libXinerama, libXft, zlib, patches ? null }:

stdenv.mkDerivation rec {
  name = "dmenu3-gist";

  src = fetchgit {
    url = "https://gist.github.com/95b99316ab6aff551cbc94831b59fbbb.git";
    sha256 = "1kp8jbkiga9gl72djgcr1z97z9ljmpsga9bh14f4c9ag8lhkwhva";
    rev = "4b0b48fdf8cfe5816d4b32bfc432213aecf95230";
  };

  buildInputs = [ libX11 libXinerama zlib libXft ];
  makeFlags = [ "PREFIX=$(out)" ];
}
