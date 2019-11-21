{ buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  name = "gitbatch-${version}";
  version = "2019-10-08";

  src = fetchFromGitHub {
    owner = "isacikgoz";
    repo = "gitbatch";
    rev = "54cb346dcde64b6ba4c8d878930b915dbaa4cc14";
    sha256 = "1bsi0s48mwmflx7g52729qi1cqd4jp2jl3gb2h13mf06lxg1m2zc";
  };

  modSha256 = "1i51lgzrnayxkyn2fzapngrcpbcr5bzzk4fsl4hc00c3csxbxa4q";
}
