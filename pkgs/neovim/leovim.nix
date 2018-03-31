{ pkgs, ... }:

pkgs.neovim.override {
  vimAlias = true; 
  configure.vam.knownPlugins = pkgs.vimPlugins // pkgs.customVimPlugins;
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
    "vimshell"
    #"vimproc"
    #"conque"
    "vim-tutor-mode"
    "ale"
    #"disco"
    "UltiSnips"
    "undotree"
    "deoplete-nvim"
    #"Supertab"
    "goyo"
    "limelight-vim"
    "fzf-vim"
    "fzfWrapper"
  ];
  configure.customRC = ''
    set laststatus=0
    source ~/.config/nvim/init.vim
  '';
}
