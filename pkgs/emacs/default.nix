{ emacs, emacsPackagesNg, lib, runCommand, imagemagick, ... }:
let 
  customEmacsPackages = emacsPackagesNg.overrideScope' (self: super: {
    emacs = (emacs.override { inherit imagemagick; } ).overrideAttrs (old: { configureFlags = 
    [ "--with-modules" "--with-x-toolkit=yes" "--without-toolkit-scroll-bars" "--with-xft" # "--with-xwidgets" 
    ];
  });
});
in

customEmacsPackages.emacsWithPackages (epkgs: (with epkgs; [
  # (runCommand "default.el" {} ''
  #   mkdir -p $out/share/emacs/site-lisp
  #   cp ${orgEmacsConfig} $out/share/emacs/site-lisp/default.el
  # '')
  use-package
]))
