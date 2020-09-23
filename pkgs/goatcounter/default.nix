{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "goatcounter-${version}";
  version = "2020-09-19";

  src = fetchFromGitHub {
    owner = "zgoat";
    repo = "goatcounter";
    rev = "4e5e42af6fd0dd2218870194b227192f076041d6";
    sha256 = "1yhbkbqd5yy8drj3rxpl0pzhdgbxrixc3b20f9x2hsjzxmva2wyr";
  };

  subPackages = [ "./cmd/goatcounter" ];

  vendorSha256 = "sha256-M50Yz7gtloGx3xU9xRG9IzbSGBiwxwFhoqIplL7Agr8=";

  meta = with lib; {
    description = "Easy web analytics. No tracking of personal data.";
    homepage = "https://github.com/zgoat/goatcounter";
    license = licenses.eupl12;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
