{ config, pkgs, lib, ... }:
let
  name = "blog";
  domain = "blog.com";
  localAddress = "10.0.0.2";
  hostAddress  = "10.0.0.1";
in
{
  containers."${name}" = {
    privateNetwork = true;
    inherit localAddress hostAddress;
  
    autoStart = false;
    
    # Container system configuration:
    config = { config, pkgs, ... }: {

      users.extraUsers.user = {
        isNormalUser = true;
        uid = 1000;
        extraGroups = [ "wheel" ];
        shell = pkgs.bash;
      };
  
      environment.systemPackages = with pkgs; [ 
        vim
        w3m
        netcat
      ];
  
      services.nginx = {
        enable = true;
        virtualHosts."${domain}" = {
          listen = [ { addr = "${localAddress}"; port = 80; } ];
          enableACME = false;
          forceSSL = false;
          root = "/var/www";
        };
      };

      services.openssh.enable = true;

      networking.firewall.enable = true;
      networking.firewall.allowedTCPPorts = [ 8080 80 21 22 ];
  
      networking.hosts = {
        "${localAddress}" = [ "localhost" ];
      };
  
      system.stateVersion = "17.09";
    };
  };
  networking.hosts."${localAddress}" = [ "${domain}.local" ];
}
