{ pkgs, emacsPackagesNgGen, emacs, ... }:
let
  customEmacsPackages = emacsPackagesNgGen ((emacs.override {
    withX = true;
    withGTK3 = true;
    withXwidgets = true;
  }).overrideAttrs (oldAttrs: {
    configureFlags = oldAttrs.configureFlags
      ++ [ "--without-toolkit-scroll-bars" ];
  }));
  emacs-with-packages = customEmacsPackages.emacsWithPackages (epkgs: [
    # Native Emacs packages
    epkgs.closql
    epkgs.editorconfig
    epkgs.forge
    epkgs.zmq
    pkgs.notmuch.emacs
  ]);
  emacs-with-paths = pkgs.symlinkJoin {
    name = builtins.replaceStrings [ "emacs-with-packages" ] [ "emacs-custom" ]
      emacs-with-packages.name;
    paths = [ emacs-with-packages ];
  };
in emacs-with-paths
