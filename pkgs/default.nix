self: super:

{
  # Custom packages
  nixos-cli = super.callPackage ./nixos-cli/default.nix {};
  athame-zsh = super.callPackage ./zsh/athame-zsh.nix {};
  athameVim = super.callPackage ./vim/athameVim.nix {};
  catimg = super.callPackage ./catimg/default.nix {};
  chroma = super.callPackage ./chroma/default.nix {};
  eventd = super.callPackage ./eventd/default.nix {};
  n30f = super.callPackage ./n30f/default.nix {};
  sddm_theme = super.callPackage ./sddm/theme.nix {};
  torrench = super.callPackage ./torrench/default.nix {};

  # Customized packages
  ncmpcpp = super.ncmpcpp.override { visualizerSupport=true; outputsSupport=true; clockSupport=true; };
  polybar = super.polybar.override { githubSupport = true; mpdSupport = true; };
  leovim = super.callPackage ./neovim/leovim.nix {};
  _2bwm = super.callPackage ./2bwm/default.nix {};
  oh-my-zsh-custom = super.callPackage ./zsh/oh-my-zsh.nix {};
  emacs-custom = super.callPackage ./emacs/default.nix {};
  sddm = super.sddm.overrideAttrs (old: { buildInputs = with super; [ qt5Full ] ++ old.buildInputs; });
  urxvtWithExtensions = super.rxvt_unicode_with-plugins.override { plugins = with super; [ urxvt_vtwheel urxvt_perls ]; };
  sxiv = super.sxiv.override { conf = builtins.readFile ./sxiv/config-custom.h; };
  mu = super.callPackage ./mu/default.nix {};

  # Mozilla
  mozilla = (import ../sources/links/nixpkgs-mozilla) self super;

  # Collections
  customPythonPackages = super.callPackage ./python/customPackages.nix {};
  customVimPlugins = super.callPackage ./vim/customPlugins.nix {};
}
