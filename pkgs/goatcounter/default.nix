{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "goatcounter-${version}";
  version = "unstable-2020-11-10";

  src = fetchFromGitHub {
    owner = "zgoat";
    repo = "goatcounter";
    rev = "9303ec02e214354a6c85e9868cba79e4d9abb818"; # tags/v1.4.2
    sha256 = "1d0vcchw5222q5bj1gk8ph5388qmkxyxz3zhmsz46vv64appmgaw";
  };

  subPackages = [ "./cmd/goatcounter" ];
  vendorSha256 = "sha256-2qzdF4VpJB7lw/9+5zxmUJH58dWjPS9JeVVnxjJJqX0=";

  meta = with lib; {
    description = "Easy web analytics. No tracking of personal data.";
    homepage = "https://github.com/zgoat/goatcounter";
    license = licenses.eupl12;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
