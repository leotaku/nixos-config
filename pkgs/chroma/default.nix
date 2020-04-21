{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-04-20";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "0da4bd1471dee2008916e618989061e463ceabb9";
    sha256 = "1vcq0d8w6q906mzgj8ggcyvzb3xb5jnzvip4ma0l8nr3qz9s3d7w";
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
