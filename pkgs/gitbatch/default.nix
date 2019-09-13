{ buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "gitbatch-${version}";
  version = "master";

  src = fetchFromGitHub {
    owner = "isacikgoz";
    repo = "gitbatch";
    rev = "${version}";
    sha256 = "1aw4179mdk5ywlj8r397q0s2xw7f2w4w3nrgh8h47bjl97r8w7np";
  };

  modSha256 = "0w9680bwwdgvkbachn2p9r4jdm6kllazvx93p46a7rriqxpspxpy";
}
