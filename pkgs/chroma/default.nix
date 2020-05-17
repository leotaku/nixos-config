{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2020-05-17";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "500529fd43c17001ae527379fd925715c2e9657c";
    sha256 = "1yiqll4lvgjq0jh0d317hcm8jjc7fpyg5qs933ayq3gbh2zpllpa";
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
