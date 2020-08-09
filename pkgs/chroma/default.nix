{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-07-28";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "477ad4aefdf2501f92e0a2261572bfc2cc2c9cb2";
    sha256 = "01bqyhviqms1zhn9nndjyi4i27w6d8q5zjfqfnc9vciikh2kl8d4";
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
