{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-05-14";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "4065717136338e8f87fd451f019d35d3a1f7419f";
    sha256 = "0rnjvw52bq5px1d8hzrxjqn4y0hfdv1k0wgnfw5y3mxxw5l1ik0y";
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
