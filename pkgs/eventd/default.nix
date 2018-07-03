{ fetchFromGitHub, stdenv, pkgs,  ... }:
let
  srcs = {
    eventd = fetchFromGitHub {
      owner = "sardemff7";
      repo = "eventd";
      rev = "v0.24.1";
      sha256 = "1qgna5ff5jjldhpqzwfkakd02fg07ysaawsjq47drgqjky8hhxxp";
    };
    libgwater = fetchFromGitHub {
      owner = "sardemff7";
      repo = "libgwater";
      rev = "e6faf48";
      sha256 = "16bfihwbfnbncqmqxqaj9ks5p1bi0rmlm73kbhq2wvmjz9py66if";
    };
    libnkutils = fetchFromGitHub {
      owner = "sardemff7";
      repo = "libnkutils";
      rev = "04362cb";
      sha256 = "0lb4d10pvp9j3cjzz4ksxr591f1q3l95i4yai8jkd5p1wk5ps5wb";
    };
  };
in
stdenv.mkDerivation rec {
  name = "eventd-${version}";
  version = "v0.24.1";

  src = srcs.eventd; 

  prePatch = ''
  substitute ./meson.build ./meson.build --replace ">=0.44.1" ">=0.43.1"
  cp ${srcs.libgwater}/* -r src/libgwater
  cp ${srcs.libnkutils}/* -r src/libnkutils
  '';

  mesonFlags = [ 
    "-Dnd-wayland=false" 
    "-Dlibcanberra=false"
    "-Dipv6=false"
    "-Dsystemd=false"
    "-Dnotification-daemon=true"
    "-Dnd-xcb=true"
    "-Dnd-fbdev=false"
    "-Dim=false"
    "-Dsound=false"
    "-Dtts=false"
    "-Dwebhook=false"
    "-Dlibnotify=true"
    "-Dlibcanberra=false"
    "-Dgobject-introspection=false"
    "-Ddebug=false"

    "-Ddbussessionservicedir=$(out)/dbus"
  ];
  
  propagatedBuildInputs = with pkgs; [
    cairo
    dbus_glib
    gdk_pixbuf
    libxkbcommon
    pango
    utillinux
    xorg.xcbutilwm
    #xorg.xcbutil
    #xorg.libxcb
    #speechd
    #libxkbcommon
    #libsoup
    #libsndfile
    #librsvg
    #libpulseaudio
    ##systemd
    ##pidgin
    ##libudev
    ##libcanberra
    ##gssdp
    ##glibc
    ##glib-networking
    ##avahi
  ];

  buildInputs = with pkgs; [
    git
    meson
    pkgconfig
    ninja
    libxslt
    docbook_xml_xslt
    docbook_xml_dtd_45
  ];
}
