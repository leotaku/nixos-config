{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-07-16";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "4da591c8f6258f012cf24d1335011981be9494c2";
    sha256 = "066a6rdmf670d3v5sc7chbn7db09ldgxjympb03pcqwk644dixb1";
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
