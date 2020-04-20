{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-04-14";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "28041a86ba9fd97c2d034a631929405354f3f541";
    sha256 = "13pnrar1yhpnlnvall1hbccyvsj9778damqhgavvaxx6m1n7kzia";
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
