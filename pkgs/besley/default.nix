{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  pname = "besley";
  version = "unstable-2022-08-12";

  src = fetchFromGitHub {
    owner = "indestructible-type";
    repo = "Besley";
    rev = "0b79b0542eb0137a3a43d165634d96b38e1a4d27";
    sha256 = "0h0ci8ibdj508r77382v9ippdd1i7alvmlbyd0ifgv05ggh6qfyb";
  };

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp fonts/ttf/* $out/share/fonts/truetype
  '';

  meta = with lib; {
    description = "An original font created by indestructible type*";
    homepage = "https://github.com/indestructible-type/Besley";
    license = licenses.ofl;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
