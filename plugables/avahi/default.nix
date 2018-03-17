{ config, pkgs, lib, ...}:
{
  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      domain = true;
      userServices = true;
      addresses = true;
    };
  };
}
