{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "goatcounter-${version}";
  version = "2.0.4";

  src = fetchFromGitHub {
    owner = "zgoat";
    repo = "goatcounter";
    rev = "283de6ae647612cd2ce53c3fe1a21da8c129fac6"; # tags/v2.0.4
    sha256 = "1r4af5rympch22l67f8cwla94bya2fhqndaac8f23b4qv11ikv9d";
  };

  subPackages = [ "./cmd/goatcounter" ];
  vendorSha256 = "sha256-z9SoAASihdTo2Q23hwo78SU76jVD4jvA0UVhredidOQ=";
  doCheck = false;

  meta = with lib; {
    description = "Easy web analytics. No tracking of personal data.";
    homepage = "https://github.com/zgoat/goatcounter";
    license = licenses.eupl12;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
