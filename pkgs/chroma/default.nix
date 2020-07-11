{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-07-08";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "e62d93f4aabfa3f0140c0863d2f33c9b94719b7e";
    sha256 = "00d06ag786v02209d4m1cygchxp2bssxym9bbx2wfhys2887sphr";
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
