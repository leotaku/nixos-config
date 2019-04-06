{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "0.6.3";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "v${version}";
    sha256 = "1rmd3pdaw3pvhq6cx8cvzw5vyn3safgflh1dzrgsw3pj78i63cg2";
  };

  modSha256 = "1d7p1mypv43md3ggg92i9nzzrhppr30rci0vk3vl00i9pbbl49ry";

  meta = with lib; {
    description = "nil";
    homepage = https://github.com/alecthomas/chroma/;
    license = licenses.mit;
    maintainers = with maintainers; [];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
