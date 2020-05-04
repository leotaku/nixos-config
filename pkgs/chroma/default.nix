{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-05-04";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "6b8ef36ed9ed1e32031d5b710294e9cbab4d8c15";
    sha256 = "0zbl38163kfjnlzvy01mn50f82r0093m8c3p9hhb9mzmgakw89bg";
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
