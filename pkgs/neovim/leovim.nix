{ pkgs, ... }:
pkgs.neovim.override {
  vimAlias = true; 
  withPython3 = true;
  extraPython3Packages = with pkgs.python3Packages; [ jedi typing ];

  configure.vam.knownPlugins = pkgs.vimPlugins // pkgs.customVimPlugins;
  configure.vam.pluginDictionaries = [
    # General
    "Mundo"
    "denite"
    "fzf-vim"
    "fzfWrapper"
    "neomru"
    "vim-startify"
    "winresizer"
    #"ctrlp"
    #"The_NERD_tree" 
    #"nerdtree-git-plugin"
    #"vimshell"

    # Editing
    "surround"
    "CamelCaseMotion"
    "multiple-cursors"
    "shot-f"
    "vim-sexp"
    "vim-swap"
    "vim-sneak"
    "auto-pairs"
    #"clever-f"
    #"easymotion"
    #"endwise"
    #"multiselect"

    # Completion + Other
    "ale"
    "UltiSnips"
    #"vim-mucomplete"
    #"deoplete-nvim"
    #"deoplete-jedi"
    #"deoplete-go"
    #"deoplete-rust"
    #"Supertab"
    #"nvim-completion-manager"
    #"snipmate"
    #"vim-snippets"

    # Ncm2
    "nvim-yarp"
    "ncm2"
    "ncm2-ultisnips"
    "ncm2-path"
    "ncm2-syntax"
    "neco-syntax"
    "ncm2-bufword"
    "ncm2-tmux"
    "ncm2-racer"

    ## Ctags
    "Tagbar"
    #"vim-gutentags"
    #"TagHighlight"
    #"vim-easytags"

    # Writing
    "vim-pencil"
    "vim-grammarous"
    #"vim-wordy"

    # Markup Languages
    "vimtex"
    "vim-pandoc-syntax"
    "vim-pandoc"
    "vim-pandoc-after"
    "vim-instant-markdown"
    #"vim-rmarkdown"
    #"vimpreviewpandoc"
    #"table-mode"

    # Programming Languages
    "vim-nix"
    "elm-vim"
    "rust-vim"
    "vim-fish"
    "vim-slime"
    "vim-javascript"
    #"parinfer-rust"
    #"slimv"
    "vim-go"
    "vim-delve"
    "julia-vim"
    "vim-toml"
    "neco-vim"

    # Source Control
    "fugitive"
    #"gitgutter"
    #"gitv"

    # Org
    #"vimwiki"
    #"vim-orgmode"
    #"vim-speeddating"

    # Tools
    #"vim-tutor-mode"

    # Visual
    "goyo"
    "limelight-vim"
    "lightline-vim"
    #"rainbow"
    #"vim-minimap"
    #"airline"
    #"vim-airline-themes"
    #"disco"

    # Input Handling
    #"vim-autoswap"

    ## Lib
    "vim-express"
    "vim-operator-user"
    "repeat"
    #"SyntaxRange"
    ##"genutils"
    ##"vimproc"
  ];
  configure.customRC = ''
    set laststatus=0
    source ~/.config/nvim/init.vim
  '';

}
