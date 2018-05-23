{ pkgs, ... }:
pkgs.neovim.override {
  vimAlias = true; 
  configure.vam.knownPlugins = pkgs.vimPlugins // pkgs.customVimPlugins;
  configure.vam.pluginDictionaries = [
    # Nix
    "vim-nix"

    # General
    "vim-startify"
    "undotree"
    "fzf-vim"
    "fzfWrapper"
    #"vimshell"
    #"The_NERD_tree" 
    #"nerdtree-git-plugin"

    # Editing
    "surround"
    "multiple-cursors"
    "vim-sexp"
    #"auto-pairs"
    #"easymotion"
    #"vim-sneak"

    # Completion + Other
    "ale"
    "deoplete-nvim"
    "deoplete-jedi"
    "Supertab"
    #"UltiSnips"

    # Markup Languages
    #"vim-instant-markdown"
    #"vim-pandoc-syntax"
    #"vim-rmarkdown"
    #"vim-pandoc"
    #"vim-pandoc-after"
    #"vimpreviewpandoc"
    #"table-mode"
    #"vim-tutor-mode"

    # Programming Languages
    "vim-slime"
    "parinfer-rust"
    #"slimv"

    # Visual
    "goyo"
    "limelight-vim"
    #"disco"

    # Lib
    #"vimproc"
    "vim-operator-user"
  ];
  configure.customRC = ''
    set laststatus=0
    source ~/.config/nvim/init.vim
  '';

}
