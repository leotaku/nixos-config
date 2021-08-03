{ stdenv, fetchurl, imagemagick, cmake, gcc, lib }:

stdenv.mkDerivation rec {
  name = "build2-${version}";
  version = "0.13.0";

  src = fetchurl {
    url = "https://download.build2.org/0.13.0/build2-toolchain-0.13.0.tar.gz";
    sha256 = "04av9qplinypfq5sv1kyccgd0sy4xb14p71rz3ndj6sir78gvsab";
  };

  buildInputs = [ gcc ];

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  buildPhase = ''
    # Phase 1
    cd build2
    make -f bootstrap.gmake -j 8 CXX=g++
    # Phase 2
    build2/b-boot config.cxx=g++ config.bin.lib=static build2/exe{b}
    mv build2/b build2/b-boot
    cd ..
    # Phase 3
    build2/build2/b-boot configure        \
      config.cxx=g++                      \
      config.bin.lib=shared               \
      config.bin.rpath=$out/lib           \
      config.install.root=$out            \
      config.install.data_root=root
    build2/build2/b-boot update: build2/ bpkg/ bdep/
  '';

  installPhase = ''
    mkdir $out
    build2/build2/b-boot install: build2/ bpkg/ bdep/
  '';

  meta = with lib; {
    description = "The build2 toolchain amalgamation (bootstrapped)";
    homepage = "https://build2.org";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.linux ++ platforms.darwin;
  };
}
