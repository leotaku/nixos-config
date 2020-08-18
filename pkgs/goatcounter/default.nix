{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "goatcounter-${version}";
  version = "2020-08-17";

  src = fetchFromGitHub {
    owner = "zgoat";
    repo = "goatcounter";
    rev = "6bb9b1eea2d6c9ae3eb084c6438b21e86f0093df";
    sha256 = "0fjp053bck06m2i77c9x1ayzm3jwgscl780wlsbvaz534fs403lg";
  };

  subPackages = [ "./cmd/goatcounter" ];

  vendorSha256 = "1lapsgi4npffadsqqlk7zjilm29al8s1lm1js65h6ad9vlawgr16";

  meta = with lib; {
    description = "Easy web analytics. No tracking of personal data.";
    homepage = "https://github.com/zgoat/goatcounter";
    license = licenses.eupl12;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
