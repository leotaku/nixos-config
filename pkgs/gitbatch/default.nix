{ buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "gitbatch-${version}";
  version = "master";

  src = fetchFromGitHub {
    owner = "isacikgoz";
    repo = "gitbatch";
    rev = "${version}";
    sha256 = "1bsi0s48mwmflx7g52729qi1cqd4jp2jl3gb2h13mf06lxg1m2zc";
  };

  modSha256 = "1i51lgzrnayxkyn2fzapngrcpbcr5bzzk4fsl4hc00c3csxbxa4q";
}
