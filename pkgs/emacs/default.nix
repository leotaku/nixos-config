{ pkgs, emacsPackagesNgGen, emacs, imagemagick, ... }:
let
  customEmacsPackages = emacsPackagesNgGen (
    (emacs.override {
      inherit imagemagick;
      withX = true;
      withGTK3 = true;
      withXwidgets = true;
    }).overrideAttrs (oldAttrs: {
      configureFlags = oldAttrs.configureFlags ++ [
        "--without-toolkit-scroll-bars"
      ];
    })
  );
in customEmacsPackages.emacsWithPackages (epkgs: [
  # Native Emacs packages
  epkgs.closql
  epkgs.editorconfig
  epkgs.forge
  epkgs.jupyter
  epkgs.vterm
  epkgs.zmq
  pkgs.notmuch
])
