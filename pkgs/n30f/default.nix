{ stdenv, fetchFromGitHub, cairo, lib }:

stdenv.mkDerivation rec {
  pname = "n30f";
  version = "unstable-2020-04-11";

  src = fetchFromGitHub {
    repo = "n30f";
    owner = "sdhand";
    rev = "08d1b273ce336be0928fa672fc1c0a4625ba50aa";
    sha256 = "0n84vnvqkrrjy7m4vvm35p91xncmy1qfiwmly2mmh28vhifsqnjm";
  };

  buildInputs = [ cairo ];
  makeFlags = [ "DESTDIR=$(out)" "PREFIX=" ];

  meta = with lib; {
    description =
      "Display a png in a borderless and transparent non-wm-managed window";
    homepage = "https://github.com/sdhand/n30f";
    license = licenses.wtfpl;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
