{ stdenv, fetchFromGitHub
, cmake, glew, libpulseaudio, glfw3 }:
let
  version = "37951a0";
in
let
srcs = {
  music_vis = fetchFromGitHub {
    owner  = "xdaimon";
    repo   = "music_visualizer";
    rev    = "${version}";
    sha256 = "02na5m3xpa5k388lg82djxqqh93wkqm9vdgggi4yvvkg8ck3fll2";
  };
  ffts = fetchFromGitHub {
    owner  = "xdaimon";
    repo   = "ffts";
    rev    = "7637405";
    sha256 = "17lbspxh41xl16zrkw9rmwmn1rc06m5k1g2ihkbg3y61zpiysnvx";
  };
  simpleFileWatcher = fetchFromGitHub {
    owner  = "xdaimon";
    repo   = "SimpleFileWatcher";
    rev    = "cafdfed";
    sha256 = "1wb5mg6p6zva786p7imk4lh7kzzq9li4w69vm32bna21ajicak0k";
  };
  rapidjson = fetchFromGitHub {
    owner  = "Tencent";
    repo   = "rapidjson";
    rev    = "af223d4";
    sha256 = "1rcyqxf36n178kfifszfd01n1sbbgjzn7z6ysp9k25di6hmqfcbd";
  };
};
in
stdenv.mkDerivation rec {
  inherit version;
  name = "music-visualizer-${version}";

  buildInputs = [ cmake glew libpulseaudio glfw3 ];

  src = srcs.music_vis;

  phases = [ "unpackPhase" "configurePhase" "buildPhase" "installPhase" ];

  configurePhase = ''
  cp -r ${srcs.ffts}/* libs/ffts
  cp -r ${srcs.simpleFileWatcher}/* libs/SimpleFileWatcher
  cp -r ${srcs.rapidjson}/* libs/rapidjson
  '';

  buildPhase = ''
  mkdir build
  cd build
  cmake .. && make -j4
  '';

  installPhase = ''
  mkdir -p $out/lib/music_visualizer
  ls .
  mv main $out/lib/music_visualizer/main
  cp -r ../src/shaders $out/lib/music_visualizer/shaders
  '';
}
