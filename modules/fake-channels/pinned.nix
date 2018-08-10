{ pkgs ? (import <nixpkgs> {})}:
let
srcs = {
  impala = pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs-channels";
    rev = "nixos-18.03";
    sha256 = "000nk8qnf158viwfg06dqwdam98v7a3fj834q548jjz0pw4pbpns";
  };
  master = pkgs.fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "master";
    sha256 = "1gn8ggil7fa7blwpynf6vwvxapa5nk28wq2kzm1p6951bw68m9av";
  };
};
in
{
  impala = (import srcs.impala {});
  master = (import srcs.master {});
}
