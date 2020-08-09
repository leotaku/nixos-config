{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "goatcounter-${version}";
  version = "2020-08-07";

  src = fetchFromGitHub {
    owner = "zgoat";
    repo = "goatcounter";
    rev = "c143d941e4612601e0d04e62873ef047eb68e5c0";
    sha256 = "18l82phdb6vgd7k8p5ryi7hk794jb5sr8d50nd0iv4ysja2iv1cs";
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
