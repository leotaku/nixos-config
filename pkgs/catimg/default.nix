{ stdenv, fetchFromGitHub, imagemagick, cmake, lib }:

stdenv.mkDerivation rec {
  name = "catimg-${version}";
  version = "unstable-2020-12-10";

  src = fetchFromGitHub {
    repo = "catimg";
    owner = "posva";
    rev = "759ff22a85bad22cbfc17e9c06ee92bad6fe1a4d";
    sha256 = "1faxf8pqld9mxswb4zk1g7fdi6wgjxk9wd4xxvdqry7g08w9v6z6";
  };

  nativeBuildInputs = [ cmake ];
  propagatedBuildInputs = [ imagemagick ];

  meta = with lib; {
    description = "Insanely fast image printing in your terminal";
    homepage = "https://github.com/posva/catimg";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
