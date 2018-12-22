{ emacs, emacsPackagesNg, lib, runCommand, imagemagick, ... }:
let 
  customEmacsPackages = emacsPackagesNg.overrideScope' (self: super: {
    emacs = (emacs.override { inherit imagemagick; });
  });
in

customEmacsPackages.emacsWithPackages (epkgs: (with epkgs; [
  # (runCommand "default.el" {} ''
  #   mkdir -p $out/share/emacs/site-lisp
  #   cp ${orgEmacsConfig} $out/share/emacs/site-lisp/default.el
  # '')
  use-package
  # evil
  # org-evil
  # evil-collection

  # ivy
  # helm

  # org
  # auctex
  # nix-mode
  # rust-mode

  # parinfer

  # select-themes
]))
