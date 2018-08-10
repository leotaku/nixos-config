{ config, pkgs, ... }:

{
  users.extraUsers.throwaway = {
    isNormalUser = false;
    createHome = true;
    home = "/home/throwaway";
    extraGroups = [ ];
    useDefaultShell = true;
  };

  security.sudo.extraConfig = ''
    ALL ALL=(throwaway) NOPASSWD: ALL
  '';
}
 
