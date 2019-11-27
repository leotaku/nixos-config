{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2019-11-24";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "28dcb8565c0eca2136ca9256a240a9fe2701b553";
    sha256 = "0sc5jgnpl3q42f4cskwlv9cdv8siyvp1v2cbpal92vvmw1jpqim6";
  };

  modSha256 = "04n24r0vd0z283n0qjnf0200l6x4i8r5kadq6aibscdmaf3ynzya";

  meta = with lib; {
    description = "nil";
    homepage = "https://github.com/alecthomas/chroma/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
