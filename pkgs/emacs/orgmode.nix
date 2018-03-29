{ emacs25-nox, emacsPackagesNg, orgEmacsConfig, lib, runCommand, ... }:
let 
  customEmacsPackages = emacsPackagesNg.overrideScope (super: self: {
    emacs = emacs25-nox;
  });
in

customEmacsPackages.emacsWithPackages (epkgs: (with epkgs; [
  (runCommand "default.el" {} ''
    mkdir -p $out/share/emacs/site-lisp
    cp ${orgEmacsConfig} $out/share/emacs/site-lisp/default.el
  '')
  evil
  evil-org
  org
  use-package
]))
