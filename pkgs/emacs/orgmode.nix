{ emacs26, emacsPackagesNg, orgEmacsConfig, lib, runCommand, ... }:
let 
  customEmacsPackages = emacsPackagesNg.overrideScope (super: self: {
    emacs = emacs26;
  });
in

customEmacsPackages.emacsWithPackages (epkgs: (with epkgs; [
  (runCommand "default.el" {} ''
    mkdir -p $out/share/emacs/site-lisp
    cp ${orgEmacsConfig} $out/share/emacs/site-lisp/default.el
  '')
  evil
  evil-org
  evil-collection
  org
  use-package
  ivy
  select-themes
]))
