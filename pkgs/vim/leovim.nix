{ pkgs, ... }:

pkgs.neovim.override {
  vimAlias = true; 
  withRuby = false;
  configure.vam.knownPlugins = pkgs.vimPlugins // pkgs.vimPluginsLeo;
  configure.vam.pluginDictionaries = [
    "vim-nix"
    "vim-instant-markdown"
    "vim-pandoc-syntax"
    "vim-rmarkdown"
    "vim-pandoc"
    "vim-pandoc-after"
    "table-mode"
    #"vimpreviewpandoc"
    "surround"
    "vim-startify" 
    "The_NERD_tree" 
    "nerdtree-git-plugin"
  ];
  configure.customRC = ''
    set laststatus=0
    source ~/.config/nvim/init.vim
  '';
}
