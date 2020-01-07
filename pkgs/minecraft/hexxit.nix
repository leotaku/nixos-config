{ stdenv, fetchzip, jre }: 

stdenv.mkDerivation rec {
  pname = "forge-server";
  version = "1.12.2";

  src = fetchzip {
    url = "http://servers.technicpack.net/Technic/servers/hexxit/Hexxit_Server_v1.0.10.zip";
    sha256 = "1pxsbk2vfbzd38vybgg9vsrm6x77gvjxsf0gr0qdnmrs72wj4vdv";
    stripRoot = false;
  };

  phases = [ "installPhase" ];

  preferLocalBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib

    cp -r ${src} $out/lib/minecraft
    
    cat > $out/bin/minecraft-server << EOF
    #!/bin/sh
    exec ${jre}/bin/java \$@ -jar $out/lib/minecraft/minecraft_server.jar nogui
    EOF
    chmod +x $out/bin/minecraft-server
  '';
}
