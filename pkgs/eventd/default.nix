{ fetchFromGitHub, stdenv, pkgs,  ... }:
let
  srcs = {
    eventd = fetchFromGitHub {
      owner = "sardemff7";
      repo = "eventd";
      rev = "87c742d";
      sha256 = "0ygckfngq7bk0350h2z5ip7ksglhrxlikqg58vwy484j6iwvd33p";
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
      rev = "4431565";
      sha256 = "0aba6lf7jslysvpbsqh0ch9bz41s9xcpr5xydp6b2rr8xra1lvqz";
    };
  };
in
stdenv.mkDerivation rec {
  name = "eventd-${version}";
  version = "master";

  src = srcs.eventd; 

  prePatch = ''
  substitute ./meson.build ./meson.build --replace ">=0.47.0" ">=0.43.1"
  substitute ${srcs.libnkutils}/meson.build ./meson.build --replace ">=0.47.0" ">=0.43.1"
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
    "-Dnd-fbdev=true"
    "-Dim=false"
    "-Dsound=false"
    "-Dtts=false"
    "-Dwebhook=false"
    "-Dlibnotify=true"
    "-Dlibcanberra=false"
    "-Dgobject-introspection=false"
    "-Ddebug=true"

    "-Ddbussessionservicedir=etc/dbus"
  ];

  propagatedBuildInputs = with pkgs; [
    cairo
    dbus_glib
    gdk_pixbuf
    libxkbcommon
    pango
    utillinux
    xorg.xcbutilwm
    xkeyboard_config
    #xorg.xcbutil
    #xorg.libxcb
    #speechd
    #libxkbcommon
    #libsoup
    #libsndfile
    #librsvg
    #libpulseaudio
    #systemd
    #pidgin
    #libudev
    #libcanberra
    #gssdp
    #glibc
    #glib-networking
    #avahi
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
