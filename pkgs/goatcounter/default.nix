{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule {
  pname = "goatcounter";
  version = "2.3.0";

  src = fetchFromGitHub {
    owner = "zgoat";
    repo = "goatcounter";
    rev = "bf8169d115d2831a0a5dc8055694fca90d00b982"; # tags/v2.3.0
    sha256 = "0lr0k5hf9g2r915yci3ixvq5iwilv2g77pwc16x5qc70j18lsdig";
  };

  subPackages = [ "./cmd/goatcounter" ];
  vendorSha256 = "sha256-u+AXkAoaV3YrHyhpRjNT2CiyDO6gkM3lidgyEQNvGso=";
  doCheck = false;

  meta = with lib; {
    description = "Easy web analytics. No tracking of personal data.";
    homepage = "https://github.com/zgoat/goatcounter";
    license = licenses.eupl12;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
