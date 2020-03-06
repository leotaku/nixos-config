{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-03-05";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "4f3623dce67a1a19f99b87be1168cf3bac708c07";
    sha256 = "0712n4xm0adpxg3vn0ycznis477fas95ha3s5m4k984jpc57930w";
  };

  subPackages = [ "./cmd/chroma" ];

  modSha256 = "1q0f79fzi6zrnmb1886sv4idv9mkyi5bdipp1ivb5xhw2ql4rw16";

  meta = with lib; {
    description = "nil";
    homepage = "https://github.com/alecthomas/chroma/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
