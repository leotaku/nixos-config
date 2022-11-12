{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  pname = "besley";
  version = "unstable-2022-11-11";

  src = fetchFromGitHub {
    owner = "indestructible-type";
    repo = "Besley";
    rev = "cd24c10a8053d7287f8697721844b8a330a0043e";
    sha256 = "1prm9091d44z9zwqxz0phcqhv5f6d1868hnmiqicjcjl4air4080";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp fonts/variable/* $out/share/fonts/truetype
  '';

  meta = with lib; {
    description = "An original font created by indestructible type*";
    homepage = "https://github.com/indestructible-type/Besley";
    license = licenses.ofl;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
