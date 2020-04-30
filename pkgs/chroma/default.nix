{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-04-26";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "80f48538c4e3679d7feaa599f86159703ecb112d";
    sha256 = "02rd3x7xi4kzfgkw6b8fm8x3j9l9qzs0lcbiza2wakf58sgqkyzg";
  };

  subPackages = [ "./cmd/chroma" ];

  modSha256 = "1241ms77iy38z59566kii70azd6dpihvv1kx4kjp52zz3ahvhzga";

  meta = with lib; {
    description = "nil";
    homepage = "https://github.com/alecthomas/chroma/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
