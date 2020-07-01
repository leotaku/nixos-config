{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-06-30";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "bac6996317c811706b2ade529f31d276a1accae8";
    sha256 = "1h6vq641dabcr5f41w0g6qnlqr1y09pqb43ymfykwcs9xq7r5bnw";
  };

  subPackages = [ "./cmd/chroma" ];

  vendorSha256 = "16cnc4scgkx8jan81ymha2q1kidm6hzsnip5mmgbxpqcc2h7hv9m";

  meta = with lib; {
    description = "A general purpose syntax highlighter in pure Go";
    homepage = "https://github.com/alecthomas/chroma";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
