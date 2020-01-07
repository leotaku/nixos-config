{ stdenv, fetchurl, jre, minecraft-server }: 

stdenv.mkDerivation rec {
  pname = "forge-server";
  version = "1.12.2";

  src = ./forge;

  preferLocalBuild = true;

  phases = [ "unpackPhase" "installPhase" ];

  unpackPhase = ''
    cp -r ${src}/* .
  '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib
    cp -r . $out/lib/minecraft
    
    cat > $out/bin/minecraft-server << EOF
    #!/bin/sh
    exec ${jre}/bin/java \$@ -jar $out/lib/minecraft/server.jar nogui
    EOF
    chmod +x $out/bin/minecraft-server
  '';
}
