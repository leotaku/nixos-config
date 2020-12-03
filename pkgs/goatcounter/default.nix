{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "goatcounter-${version}";
  version = "2020-12-01";

  src = fetchFromGitHub {
    owner = "zgoat";
    repo = "goatcounter";
    rev = "89c07f70dbecf9d3e66fa7028f00a231cf7b97a4";
    sha256 = "1f5b3fscg1h6y524c011prnl7l3rsgi8hj4qz7x02sx8v84s3vc5";
  };

  subPackages = [ "./cmd/goatcounter" ];

  vendorSha256 = "sha256-cG3mJtbwBkgQnJiI0ZfVPHSMczenksNYdbnQkVy4SdQ=";

  meta = with lib; {
    description = "Easy web analytics. No tracking of personal data.";
    homepage = "https://github.com/zgoat/goatcounter";
    license = licenses.eupl12;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
