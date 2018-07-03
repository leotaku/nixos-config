{ pkgs, ... }:
pkgs.neovim.override {
  vimAlias = true; 
  withPython3 = true;
  extraPython3Packages = with pkgs.python3Packages; [ jedi typing ];

  configure.vam.knownPlugins = pkgs.vimPlugins // pkgs.customVimPlugins;
  configure.vam.pluginDictionaries = [
    # General
    "Mundo"
    "The_NERD_tree" 
    "ctrlp"
    "denite"
    "fzf-vim"
    "fzfWrapper"
    "neomru"
    "nerdtree-git-plugin"
    "vim-startify"
    "winresizer"
    #"vimshell"

    # Editing
    "surround"
    "CamelCaseMotion"
    "multiple-cursors"
    "shot-f"
    "vim-sexp"
    "vim-swap"
    #"auto-pairs"
    #"clever-f"
    #"easymotion"
    #"endwise"
    #"multiselect"
    "vim-sneak"

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
    #"snipmate"
    "vim-snippets"
    "neco-syntax"

    # Ctags
    "Tagbar"
    "vim-gutentags"
    #"TagHighlight"
    #"vim-easytags"

    # Writing
    "vim-grammarous"
    #"vim-wordy"

    # Markup Languages
    "vim-instant-markdown"
    "vim-pandoc-syntax"
    #"vim-rmarkdown"
    "vim-pandoc"
    "vim-pandoc-after"
    #"vimpreviewpandoc"
    #"table-mode"

    # Programming Languages
    "vim-nix"
    "vim-fish"
    "vim-slime"
    "parinfer-rust"
    #"slimv"
    "vim-go"
    "vim-delve"
    "vim-toml"
    "neco-vim"

    # Source Control
    "fugitive"
    #"gitgutter"
    "gitv"

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
    "vim-minimap"
    #"airline"
    #"vim-airline-themes"
    #"disco"

    # Input Handling
    #"vim-autoswap"

    # Lib
    "vim-express"
    "vim-operator-user"
    "repeat"
    "SyntaxRange"
    #"genutils"
    #"vimproc"
  ];
  configure.customRC = ''
    set laststatus=0
    source ~/.config/nvim/init.vim
  '';

}
