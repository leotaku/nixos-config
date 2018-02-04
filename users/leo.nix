# Edit this configuration file to define an users configurations
# on your systems. Help is available in the configuration.nix(5) 
# man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  ## Define an user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.leo = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    shell = pkgs.zsh;
  };
 
  ## Global configuration linked to this accourt
  
  services.mpd.enable = true;
  services.mpd.startWhenNeeded = true;

  # Enable the DE/WM + DM 
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.windowManager.herbstluftwm.enable = true;

  # Enable Zsh to avoid bugs
  programs.zsh.enable = true;

  ## Home manager configuration for this account
  home-manager.users.leo = {
    
    home.file."TEST".text = "foo";

    home.packages = with pkgs; [
      ( vim_configurable.customize {
        name = "vim";
        vimrcConfig.vam.knownPlugins = pkgs.vimPlugins // pkgs.vimPluginsLeo;
        vimrcConfig.vam.pluginDictionaries = [ "vim-instant-markdown" "vim-startify" "vim-surround" ];  
        }
      )
      gnome3.adwaita-icon-theme
      numix-icon-theme
      numix-icon-theme-square
      arc-icon-theme
      papirus-icon-theme
      paper-icon-theme
      moka-icon-theme
      xfce.xfce4-icon-theme
      siji
    ];
    
    home.sessionVariables = {
      TERMINAL = "urxvt";
      EDITOR = "nano";
      RANGER_LOAD_DEFAULT_RC = "FALSE";
    };

    gtk = {
      enable = true;
      theme.package = pkgs.adapta-gtk-theme;
      theme.name = "Adapta";
      iconTheme.package = pkgs.papirus-icon-theme;
      iconTheme.name = "ePapirus"; #ePapirus
    };

    programs.git = {
      enable = true;
      userName  = "LeOtaku";
      userEmail = "leo.gaskin@brg-feldkirchen.at";
    };

    # Font settings
    fonts.fontconfig.enableProfileFonts = true;

    # Xserver configurations
    home.keyboard.layout = "us";
    #home.keyboard.variant = "nodeadkeys";
    #home.keyboard.options = "eurosign:e";
  
    # Enable compton
    services.compton.enable = true;
    
    # Enable dunst
    services.dunst.enable = true;

  };
}
