{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-03-15";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "937aba151436263946776b8aa640865dc46fe21a";
    sha256 = "06aybhrl773s2qpm6w3gk4ir8ck7b4qacmynb27irmsa5dpi7q6f";
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
