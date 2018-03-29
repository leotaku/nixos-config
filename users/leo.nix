# Edit this configuration file to define an users configurations
# on your systems. Help is available in the configuration.nix(5) 
# man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  ## Define an user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.leo = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "vboxusers" "transmission" "wireshark" ];
    shell = pkgs.zsh;
  };
 
  ## Global configuration linked to this accourt
  
  # services.mpd = {
  #   enable = true;
  #   startWhenNeeded = true;
  #   user = "leo";
  #   group = "users";
  #   musicDirectory = "/home/leo/Music";
  #   dataDir = "/home/leo/.config/mpd";
  #   dbFile = "/home/leo/.config/mpd/database";
  #   playlistDirectory = "/home/leo/.config/mpd/playlists";

  #   extraConfig = ''
  #   audio_output {
  #       type		"pulse"
  #       name		"Audio"
  #   	always_on	"yes"
  #   	mixer_type	"software"
  #   	#buffer_time	"50000"   # (50ms); default is 500000 microseconds (0.5s)
  #   }
  #   
  #   audio_output {
  #       type 		"fifo"
  #       name		"Visualizer"
  #       path		"/tmp/mpd.fifo"
  #   	format		"44100:16:2"
  #   	#buffer_time     "50000"   # (50ms); default is 500000 microseconds (0.5s)
  #   }
  #   '';
  # };

    # Enable Zsh to get features + stupid nl
  programs.zsh.enable = true;

  ## Home manager configuration for this account
  home-manager.users.leo = {
    
    home.file."coolDir/coolTEST".text = "foo";
    #home.file.".Xresources2".source = ../files/Xresources;

    nixpkgs = {
      config = { allowUnfree = true; };
      overlays = [ (import ../pkgs/default.nix) ];
    };

    home.packages = with pkgs; [
      gnome3.adwaita-icon-theme
      numix-icon-theme
      numix-icon-theme-square
      arc-icon-theme
      papirus-icon-theme
      paper-icon-theme
      moka-icon-theme
      xfce.xfce4-icon-theme
      #siji
      #gohufont
      #terminus_font
    ];
    
    # does fucking nothing, I really don't know anymore
    home.sessionVariables = {
      TERMINAL = "urxvt";
      EDITOR = "vim";
      RANGER_LOAD_DEFAULT_RC = "FALSE";
      BAR = "foo";
      FOO = [ "baz" ];
    };

    gtk = {
      enable = true;
      theme.package = pkgs.adapta-gtk-theme;
      theme.name = "Adapta-Eta";
      iconTheme.package = pkgs.papirus-icon-theme;
      iconTheme.name = "ePapirus"; #ePapirus
    };

    #programs.git = {
    #  enable = true;
    #  userName  = "LeOtaku";
    #  userEmail = "leo.gaskin@brg-feldkirchen.at";
    #};

    # Font settings
    fonts.fontconfig.enableProfileFonts = true;

    # Xserver configurations
    xsession = {
      enable = true;
      #pointerCursor = {
      #  size = 32;
      #  package = pkgs.gnome3.adwaita-icon-theme;
      #  name = "Adwaita";
      #};
      #profileExtra = "
      #xrdb -merge ~/.Xresources2
      #";
      windowManager.command = "herbstluftwm";
      initExtra = "
      feh --bg-fill ~/Images/white.png
      mpd
      compton &
      (compton &) &> /dev/null
      eventd &
      ";
    };
    home.keyboard.layout = "de";
    home.keyboard.variant = "nodeadkeys";
    #home.keyboard.options = "eurosign:e";
  
    # Enable compton
    # Run as user
    services.compton = {
      enable = false;
      backend = "glx";
      fade = true;
      fadeDelta = 5;
      shadow = true;
    };

    # Enable dunst
    services.dunst.enable = false;
    #services.dunst.settings = builtins.readFile ../dotfiles/dunstrc;

  };
}
