{ pkgs, ... }:

pkgs.vim_configurable.customize {
  name = "vim";
  vimrcConfig.vam.knownPlugins = pkgs.vimPlugins // pkgs.vimPluginsLeo;
  vimrcConfig.vam.pluginDictionaries = [
    "vim-instant-markdown" 
    "surround" 
    "vim-startify" 
    "The_NERD_tree" 
    "nerdtree-git-plugin"
  ];
  vimrcConfig.customRC = ''
  if &term =~ '^xterm\\|rxvt'
    " solid underscore
    let &t_SI .= "\<Esc>[4 q"
    " solid block
    let &t_EI .= "\<Esc>[6 q"
    " 1 or 0 -> blinking block
    " 3 -> blinking underscore
    " Recent versions of xterm (282 or above) also support
    " 5 -> blinking vertical bar
    " 6 -> solid vertical bar
  endif
   '';
}

