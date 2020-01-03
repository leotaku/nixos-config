{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-01-02";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "bac74c10162702fc81843c48b824150f0f4d793a";
    sha256 = "1s46gqr3wq5j6k7gwc9r7s2ck80qddv8szwl9jgr3msnayf4w8s0";
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
