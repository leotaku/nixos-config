self: super:

{
  # Custom packages
  instant-markdown-d = (super.callPackage ./instant-markdown-d/default.nix {}).package;
  gtop =  (super.callPackage ./gtop/default.nix {}).package;
  vimPluginsLeo = super.callPackage ./vim/customPlugins.nix {};
  leovim = super.callPackage ./vim/leovim.nix {};
  athame-zsh = super.callPackage ./zsh/athame-zsh.nix {};
  windowchef = super.callPackage ./windowchef/default.nix {};
  #leoVim = super.callPackage ./vim/leoVim.nix {};
  #bobthefish = super.callPackage ./bobfish/default.nix {};
}
