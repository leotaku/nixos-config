{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "goatcounter-${version}";
  version = "2020-09-28";

  src = fetchFromGitHub {
    owner = "zgoat";
    repo = "goatcounter";
    rev = "b35c86cfbd5495eccad7801cbdd0d88a53157f46";
    sha256 = "0xvzlv9ixzg5z6cqddzvri236lgjwgpi9kabh2raqrkk6s0b199a";
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
