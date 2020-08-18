{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-08-12";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "86ebaf326b96bfa021837ca89ecaf418fc8ae319";
    sha256 = "1nshwz8zrk97icvv1qcphsnm66h1fj1q820jdxbxhnnnc5afqgi1";
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
