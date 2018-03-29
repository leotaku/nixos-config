{ rxvt_unicode_with-plugins, pkgs }:

rxvt_unicode_with-plugins.override { plugins = with pkgs; [ urxvt_vtwheel urxvt_perls ]; }
