{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-01-10";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "0f6a31d4cdc69bfa2c9cbc90519b5504b8ce8601";
    sha256 = "1p45fqcmck7fham0wjlpxd88shkf11f6bd7rr9356g2h3b6rkg90";
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
