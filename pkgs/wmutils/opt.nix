{ stdenv, fetchFromGitHub, libxcb, xcbutil }:

stdenv.mkDerivation rec {
  name = "wmutils-opt-${version}";
  version = "00ea524";

  src = fetchFromGitHub {
    owner = "wmutils";
    repo = "opt";
    rev = "${version}";
    sha256 = "1kp6aql2ibvvpccjf4cij0pdlgxssdzi6pk8dwia30xwg6r09nws";
  };

  buildInputs = [ libxcb xcbutil ];

  installFlags = [ "PREFIX=$(out)" ];

  meta = with stdenv.lib; {
    description = "Optional addons to wmutils";
    homepage = https://github.com/wmutils/opt;
    license = licenses.isc;
    maintainers = with maintainers; [ vifino ];
    platforms = platforms.unix;
  };
}
