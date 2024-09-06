{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule {
  pname = "goatcounter";
  version = "2.5.0";

  src = fetchFromGitHub {
    owner = "zgoat";
    repo = "goatcounter";
    rev = "ca25fa9ab8d74c8f76a6f2b62f7fca38eb2afe32"; # tags/v2.5.0
    sha256 = "15drmf8qv3rr8xg3jcyqcnc2wa82wr7sbqr0q487xi8qys9qn24p";
  };

  subPackages = [ "./cmd/goatcounter" ];
  vendorHash = "sha256-YAb3uBWQc6hWzF1Z5cAg8RzJQSJV+6dkppfczKS832s=";
  doCheck = false;

  meta = with lib; {
    description = "Easy web analytics. No tracking of personal data.";
    homepage = "https://github.com/zgoat/goatcounter";
    license = licenses.eupl12;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
