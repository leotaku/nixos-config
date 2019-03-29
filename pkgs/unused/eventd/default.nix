{ fetchFromGitHub, stdenv, pkgs,  ... }:
let
  srcs = {
    eventd = fetchFromGitHub {
      owner = "sardemff7";
      repo = "eventd";
      rev = "d7c7ba59aa6b225b3e2b8aebdd853137c05d8445";
      sha256 = "1zabgn7l9ipn3f1bmd4pbjs702l5fp6r7bfz5fshia8iala49rxb";
    };
    libgwater = fetchFromGitHub {
      owner = "sardemff7";
      repo = "libgwater";
      rev = "67fa66253ccdd9230397577cfa80226c41200a7a";
      sha256 = "1xl9pqadam2pdx2isqj551g3v483kngw6wzhih44mbqay1wakk5b";
    };
    libnkutils = fetchFromGitHub {
      owner = "sardemff7";
      repo = "libnkutils";
      rev = "9015af623c88d17e7c361b955944ec006b77224d";
      sha256 = "061ybccfl4kw6304zfnpjdrvpwi1gnmcw6ixgxns78xb0z1xz5c5";
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
