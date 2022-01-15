{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  pname = "goatcounter";
  version = "2.1.1";

  src = fetchFromGitHub {
    owner = "zgoat";
    repo = "goatcounter";
    rev = "2461147f90cc340997710c307afe078548ffe7d6"; # tags/v2.1.1
    sha256 = "1q42g00n8pl8pj4f5mdv2mydksx28ylzabhh0cyfdvz8bsfx4klm";
  };

  subPackages = [ "./cmd/goatcounter" ];
  vendorSha256 = "sha256-Gl3JPgruQi+rjgua0JcHqG2CqJf7TDNin6IT0RywolY=";
  doCheck = false;

  meta = with lib; {
    description = "Easy web analytics. No tracking of personal data.";
    homepage = "https://github.com/zgoat/goatcounter";
    license = licenses.eupl12;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
