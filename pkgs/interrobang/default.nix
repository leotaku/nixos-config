{ fetchFromGitHub, stdenv, libX11,  ... }:

stdenv.mkDerivation rec {
  name = "interrobang-${version}";
  version = "321cd9d";

  src = fetchFromGitHub {
    owner = "TrilbyWhite";
    repo = "interrobang";
    rev = "${version}";
    sha256 = "013474fjc970dpbjygx4n67gj82z71l2cfn5w1mg9q84w6wa4mwi";
  };

  #preInstall = ''
  #substitute ./Makefile ./Makefile --replace "/bin" ""
  #'';
  
  makeFlags = [ "PREFIX=/usr" "DESTDIR=$out" ];

  #postInstall = ''
  #mkdir $out/bin
  #mv bin/release/howm $out/bin/howm
  #mv share $out
  #'';
  #
  buildInputs = [
    libX11
  ];
}
