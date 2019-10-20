{ stdenv, emacsPackagesNg, imagemagick, ... }:
let
  customEmacsPackages = emacsPackagesNg.overrideScope' (self: super: {
    emacs = (super.emacs.override { inherit imagemagick; }).overrideAttrs (oldAttrs: {
      configureFlags = [
        "--with-modules"
        "--with-x-toolkit=yes"
        "--without-toolkit-scroll-bars"
        "--with-xft"
        # "--with-xwidgets"
      ];
    });
  });
in customEmacsPackages.emacsWithPackages (epkgs: (with epkgs; [ ]))
