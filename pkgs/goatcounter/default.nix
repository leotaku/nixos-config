{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "goatcounter-${version}";
  version = "2020-10-22";

  src = fetchFromGitHub {
    owner = "zgoat";
    repo = "goatcounter";
    rev = "30cbd2355faf83c86cb8557c9d7cdf2af55f3e72";
    sha256 = "16dpzkyz66iakd38x320dx2ncgwk6fk1h67ykazwph2mx6bgcnka";
  };

  subPackages = [ "./cmd/goatcounter" ];

  vendorSha256 = "sha256-ZOQpygrLI3SmwygYRnHcxeZtFZw0NjRxOS3pfxW2KTw=";

  meta = with lib; {
    description = "Easy web analytics. No tracking of personal data.";
    homepage = "https://github.com/zgoat/goatcounter";
    license = licenses.eupl12;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
