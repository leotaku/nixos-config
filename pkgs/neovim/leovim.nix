{ pkgs, ... }:
pkgs.neovim.override {
  vimAlias = true; 
  withPython3 = true;
  extraPython3Packages = with pkgs.python3Packages; [ jedi ];

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
    "The_NERD_tree" 
    "nerdtree-git-plugin"

    # Editing
    "surround"
    #"multiple-cursors"
    "vim-sexp"
    #"auto-pairs"
    #"easymotion"
    #"vim-sneak"

    # Completion + Other
    "ale"
    #"vim-mucomplete"
    #"deoplete-nvim"
    #"deoplete-jedi"
    #"deoplete-go"
    #"deoplete-rust"
    #"Supertab"
    "nvim-completion-manager"
    "UltiSnips"
    "vim-snippets"
    "neco-syntax"

    # Ctags
    "Tagbar"
    "vim-gutentags"

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
    "vim-go"
    "neco-vim"

    # Org
    "vimwiki"
    "vim-orgmode"
    "vim-speeddating"

    # Visual
    "goyo"
    "limelight-vim"
    #"disco"

    # Lib
    "vim-express"
    "repeat"
    "SyntaxRange"
    #"vimproc"
    #"vim-operator-user"
  ];
  configure.customRC = ''
    set laststatus=0
    source ~/.config/nvim/init.vim
  '';

}
