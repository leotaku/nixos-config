{ pkgs, emacsPackagesFor, emacs, ... }:
let
  customEmacsPackages = emacsPackagesFor (emacs.overrideAttrs (oldAttrs: {
    configureFlags = oldAttrs.configureFlags ++ [
      "--without-scroll-bars"
      "--without-compress-install"
      "--with-pgtk"
      "--with-sqlite3"
    ];
    buildInputs = oldAttrs.buildInputs ++ [ pkgs.gtk3 pkgs.sqlite ];
  }));
  emacs-with-packages = customEmacsPackages.emacsWithPackages (epkgs: [
    # Native Emacs packages
    epkgs.vterm
    pkgs.mu
  ]);
  emacs-with-paths = pkgs.symlinkJoin {
    name = builtins.replaceStrings [ "emacs-with-packages" ] [ "emacs-custom" ]
      emacs-with-packages.name;
    paths = [ emacs-with-packages ];
  };
in emacs-with-paths
