{ config, lib, pkgs, ... }:

{
  # Xdg default applications
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "text/html" = "firefox.desktop";
      "text/xml" = "firefox.desktop";
      "x-scheme-handler/chrome" = "firefox.desktop";
      "x-scheme-handler/ftp" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
    defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
        "writer.desktop";
      "application/x-shellscript" = "emacs.desktop";
      "image/bmp" = "sxiv.desktop";
      "image/gif" = "sxiv.desktop";
      "image/jpeg" = "sxiv.desktop";
      "image/jpg" = "sxiv.desktop";
      "image/png" = "sxiv.desktop";
      "image/tiff" = "sxiv.desktop";
      "image/x-bmp" = "sxiv.desktop";
      "image/x-portable-anymap" = "sxiv.desktop";
      "image/x-portable-bitmap" = "sxiv.desktop";
      "image/x-portable-graymap" = "sxiv.desktop";
      "image/x-tga" = "sxiv.desktop";
      "image/x-xpixmap" = "sxiv.desktop";
      "inode/directory" = "thunar.desktop";
      "text/english" = "emacs.desktop";
      "text/html" = "firefox.desktop";
      "text/plain" = "emacs.desktop";
      "text/x-c" = "emacs.desktop";
      "text/x-c++" = "emacs.desktop";
      "text/x-c++hdr" = "emacs.desktop";
      "text/x-c++src" = "emacs.desktop";
      "text/x-chdr" = "emacs.desktop";
      "text/x-csrc" = "emacs.desktop";
      "text/x-java" = "emacs.desktop";
      "text/x-makefile" = "emacs.desktop";
      "text/x-moc" = "emacs.desktop";
      "text/x-pascal" = "emacs.desktop";
      "text/x-tcl" = "emacs.desktop";
      "text/x-tex" = "emacs.desktop";
      "text/xml" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/chrome" = "userapp-firefox.desktop";
      "x-scheme-handler/ftp" = "userapp-firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/org-protocol" = "org-protocol.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
    };
  };

  # Firefox does not register a proper entry by default
  xdg.dataFile."applications/firefox.desktop".text = ''
    [Desktop Entry]
    Encoding=UTF-8
    Name=Mozilla Firefox
    GenericName=Web Browser
    Comment=Browse the Web
    Exec=firefox
    Icon=firefox
    Terminal=false
    Type=Application
    Categories=Application;Network;WebBrowser;
    MimeType=text/html;text/xml;application/xhtml+xml;application/vnd.mozilla.xul+xml;text/mml;
    StartupNotify=True
  '';

  # Better Emacs(client) desktop
  xdg.dataFile."applications/emacs.desktop".text = ''
    [Desktop Entry]
    Name=Emacsclient
    GenericName=Text Editor
    Comment=Edit text
    MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
    Exec=emacsclient -c %F --alternate-editor=""
    Icon=emacs
    Type=Application
    Terminal=false
    Categories=Development;TextEditor;
    StartupWMClass=Emacs
    Keywords=Text;Editor;
  '';

  # Run terminal with Tmux
  xdg.dataFile."applications/rxvt-unicode.desktop".text = ''
    [Desktop Entry]
    Encoding=UTF-8
    Name=Terminal
    GenericName=Tmux in Terminal
    Comment=
    Exec=tmux
    Icon=terminal
    Terminal=true
    Type=Application
    Categories=Application;Development;
  '';

  # Register org-capture protocol
  xdg.dataFile."applications/org-protocol.desktop".text = ''
    [Desktop Entry]
    Name=org-protocol
    Exec=emacsclient %u
    Type=Application
    Terminal=false
    Categories=System;
    MimeType=x-scheme-handler/org-protocol;
  '';
}
