{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "goatcounter-${version}";
  version = "2020-09-07";

  src = fetchFromGitHub {
    owner = "zgoat";
    repo = "goatcounter";
    rev = "5748ec7bf51ea27658497fe714b42c5ecc46d654";
    sha256 = "092qgmy9scqlgsba9n859v2g6fk1x10l9yjk9f9ybhffhpcx7ivz";
  };

  subPackages = [ "./cmd/goatcounter" ];

  vendorSha256 = "06w9zqifgbh9qvs0fdhqprfrj7vvwngi9ccal1dcqryqarll5qkl";

  meta = with lib; {
    description = "Easy web analytics. No tracking of personal data.";
    homepage = "https://github.com/zgoat/goatcounter";
    license = licenses.eupl12;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
