{ pkgs, emacsPackagesFor, emacs, ... }:
let
  customEmacsPackages = emacsPackagesFor ((emacs.override {
    withX = true;
    withGTK3 = true;
    withXwidgets = true;
  }).overrideAttrs (oldAttrs: {
    configureFlags = oldAttrs.configureFlags ++ [
      "--without-toolkit-scroll-bars"
      "--without-compress-install"
      "--with-sqlite3"
    ];
    buildInputs = oldAttrs.buildInputs ++ [
      pkgs.sqlite
    ];
  }));
  emacs-with-packages = customEmacsPackages.emacsWithPackages (epkgs: [
    # Native Emacs packages
    epkgs.vterm
    pkgs.notmuch.emacs
  ]);
  emacs-with-paths = pkgs.symlinkJoin {
    name = builtins.replaceStrings [ "emacs-with-packages" ] [ "emacs-custom" ]
      emacs-with-packages.name;
    paths = [ emacs-with-packages ];
  };
in emacs-with-paths
