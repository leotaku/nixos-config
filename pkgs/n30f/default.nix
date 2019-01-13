{ stdenv, fetchFromGitHub, cairo }:

stdenv.mkDerivation rec {
  name="n30f";
  version="2016-07-29";

  src = fetchFromGitHub {
    repo="n30f";
    owner="sdhand";
    rev="b801f89d629ce57cbf2e8df0183cfc5006b40b20";
    sha256 = "044jyyc4hj4ianw850ypnn83jcsphl4s3fi4m7z3h15q2dvnsc5k";
  };

  buildInputs = [ cairo ];
  makeFlags = [
    "DESTDIR=$(out)"
    "PREFIX="
  ];
}
