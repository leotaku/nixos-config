{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-09-09";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "290ff860b9f359e2e25d5745ea0e508355896314";
    sha256 = "1gwwfn26aipzzvyy466gi6r54ypfy3ylnbi8c4xwch9pkgw16w98";
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
