{ stdenv, fetchurl, libxcb, xcbutil }:

stdenv.mkDerivation rec {
  name = "wmutils-core-${version}";
  version = "1.4";

  src = fetchurl {
    url = "https://github.com/wmutils/core/archive/v${version}.tar.gz";
    sha256 = "1fmjlwajqzgjz97pgzws51jzs43ymd4r896bq8kg3qgnnxv6bqa4";
  };

  buildInputs = [ libxcb xcbutil ];

  installFlags = [ "PREFIX=$(out)" ];

  meta = with stdenv.lib; {
    description = "Set of window manipulation tools";
    homepage = https://github.com/wmutils/core;
    license = licenses.isc;
    platforms = platforms.unix;
  };
}
