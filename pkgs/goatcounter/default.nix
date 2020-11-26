{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "goatcounter-${version}";
  version = "2020-11-23";

  src = fetchFromGitHub {
    owner = "zgoat";
    repo = "goatcounter";
    rev = "130b400fb3ad6caefc0f53c79e7277aaf637905f";
    sha256 = "0psn7qmzv0gv084nr7aj885ss0amqcfc7hg7kaqcia69dc0iafsk";
  };

  subPackages = [ "./cmd/goatcounter" ];

  vendorSha256 = "sha256-2qzdF4VpJB7lw/9+5zxmUJH58dWjPS9JeVVnxjJJqX0=x";

  meta = with lib; {
    description = "Easy web analytics. No tracking of personal data.";
    homepage = "https://github.com/zgoat/goatcounter";
    license = licenses.eupl12;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
