{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-01-30";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "498eaa690f5ac6ab0e3d6f46237e547a8935cdc7";
    sha256 = "14rqgisbh76a2gmiigkrxibdznclrlnk9br6y8w6fcbnsnawjyg0";
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
