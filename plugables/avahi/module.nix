{ config, pkgs, lib, ...}:
{
  services.avahi = {
    enable = true;
    domainName = "local";
    nssmdns = true;
    publish = {
      enable = true;
      domain = true;
      userServices = true;
      addresses = true;
    };
  };

  # Doesn't do anything, because of mdns minimal
  environment.etc."mdns.allow" = {
    enable = false;
    text = ''
      .local
    '';
  };
}
