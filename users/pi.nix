# Edit this configuration file to define an users configurations
# on your systems. Help is available in the configuration.nix(5) 
# man page and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  ## Define an user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.pi = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    shell = pkgs.zsh;
  };
 
  # Enable Zsh to get features + stupid nl
  programs.zsh.enable = true;

  ## Home manager configuration for this account
  home-manager.users.pi = {
    
    home.file."coolTEST".text = "foo";

    nixpkgs = {
      config = { allowUnfree = true; };
      overlays = [ (import ../pkgs/default.nix) ];
    };

    home.packages = with pkgs; [
      hello
    ];
    
    home.sessionVariables = {
      EDITOR = "vim";
    };

    programs.git = {
      enable = true;
      userName  = "LeOtaku";
      userEmail = "leo.gaskin@brg-feldkirchen.at";
    };

  };
}
