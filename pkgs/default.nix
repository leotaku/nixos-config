self: super:

{
  # Custom packages
  athame-zsh = super.callPackage ./zsh/athame-zsh.nix {};
  athameVim = super.callPackage ./vim/athameVim.nix {};
  catimg = super.callPackage ./catimg/default.nix {};
  eventd = super.callPackage ./eventd/default.nix {};
  gotop = super.callPackage ./gotop/default.nix {};
  instant-markdown-d = (super.callPackage ./instant-markdown-d/default.nix {}).package;
  torrench = super.callPackage ./torrench/default.nix {};

  # Customized packages
  ncmpcpp = super.ncmpcpp.override { visualizerSupport=true; outputsSupport=true; clockSupport=true; };
  polybar = super.polybar.override { githubSupport = true; mpdSupport = true; };
  leovim = super.callPackage ./neovim/leovim.nix {};
  num2bwm = super.callPackage ./2bwm/default.nix {};
  oh-my-zsh-custom = super.callPackage ./zsh/oh-my-zsh.nix {};
  orgEmacs = super.callPackage ./emacs/orgmode.nix {};
  orgEmacsConfig = super.callPackage ./emacs/configuration-package.nix {};
  sxiv = super.sxiv.override { conf = builtins.readFile ./sxiv/config.h; };

  # Collections
  customPythonPackages = super.callPackage ./python/customPackages.nix {};
  customVimPlugins = super.callPackage ./vim/customPlugins.nix {};
}
