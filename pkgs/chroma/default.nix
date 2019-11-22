{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  name = "chroma-${version}";
  version = "2019-11-22";

  src = fetchFromGitHub {
    owner = "alecthomas";
    repo = "chroma";
    rev = "5921c52787e3b02e045fbfc50d56090971220aaf";
    sha256 = "1ij5i4065m3pqh0srpcgbyz5pv3h72x1j7gmw964byfan9c5lc71";
  };

  modSha256 = "04n24r0vd0z283n0qjnf0200l6x4i8r5kadq6aibscdmaf3ynzya";

  meta = with lib; {
    description = "nil";
    homepage = "https://github.com/alecthomas/chroma/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
