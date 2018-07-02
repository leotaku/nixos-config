{ fetchFromGitHub, stdenv, scons, ragel, gtk3, lua, expat, boost, gettext,  ... }:

stdenv.mkDerivation rec {
  name = "gpick-${version}";
  version = "0.2.6rc1";

  src = fetchFromGitHub {
    owner = "thezbyg";
    repo = "gpick";
    rev = "gpick-${version}";
    sha256 = "183rfzsx6z2r13ymakdm2kpykrz799nzk4qgh1yp8libigyx12m3";
  };

  buildPhase = ''
  find .
  sed -i -e "s@env = Environment()@env = Environment( ENV = os.environ )@" SConscript
  scons USE_GTK3=true
  '' ;

  installPhase = ''
  DESTDIR=$out scons install 
  '';

  buildInputs = [
    gtk3 lua expat boost gettext scons ragel
  ];
}
