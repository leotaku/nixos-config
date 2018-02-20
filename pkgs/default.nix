self: super:

{
  # Custom packages
  instant-markdown-d = (super.callPackage ./instant-markdown-d/default.nix {}).package;
  gtop =  (super.callPackage ./gtop/default.nix {}).package;
  vimPluginsLeo = super.callPackage ./vim/customPlugins.nix {};
  leovim = super.callPackage ./vim/leovim.nix {};
  athame-zsh = super.callPackage ./zsh/athame-zsh.nix {};
  windowchef = super.callPackage ./windowchef/default.nix {};
  howm = super.callPackage ./howm/default.nix {};
  cottage = super.callPackage ./cottage/default.nix {};
  #interrobang = super.callPackage ./interrobang/default.nix {};
  gpick = super.callPackage ./gpick/default.nix {};
  # Package Overrides
  wmutils-core = super.callPackage ./wmutils/core.nix {};
  wmutils-opt = super.callPackage ./wmutils/opt.nix {};
  ncmpcpp = super.ncmpcpp.override { visualizerSupport=true; outputsSupport=true; clockSupport=true; };
  polybar = super.polybar.override { githubSupport = true; mpdSupport = true; };
  #leoVim = super.callPackage ./vim/leoVim.nix {};
  #bobthefish = super.callPackage ./bobfish/default.nix {};
}
