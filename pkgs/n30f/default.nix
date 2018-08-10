{ stdenv, fetchFromGitHub, cairo }:

stdenv.mkDerivation rec {
  name="n30f";
  version="b801f89";

  src = fetchFromGitHub {
    repo="n30f";
    owner="sdhand";
    rev="${version}";
    sha256 = "044jyyc4hj4ianw850ypnn83jcsphl4s3fi4m7z3h15q2dvnsc5k";
  };

  buildInputs = [ cairo ];
  makeFlags = [
    "DESTDIR=$(out)"
    "PREFIX="
  ];
}
