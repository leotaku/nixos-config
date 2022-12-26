{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule {
  pname = "goatcounter";
  version = "2.4.1";

  src = fetchFromGitHub {
    owner = "zgoat";
    repo = "goatcounter";
    rev = "b4126b7165aa65a17353e06ef0b7bf7127d76004"; # tags/v2.4.1
    sha256 = "10i7p63ab0khl70c7kypqbbikp18pcvsnk246vy0kncbpz8gb39g";
  };

  subPackages = [ "./cmd/goatcounter" ];
  vendorSha256 = "sha256-nKfqZ5hGGVLBY/hnJJPCrS/9MlGoR2MWFUWDnpwWgyM=";
  doCheck = false;

  meta = with lib; {
    description = "Easy web analytics. No tracking of personal data.";
    homepage = "https://github.com/zgoat/goatcounter";
    license = licenses.eupl12;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
