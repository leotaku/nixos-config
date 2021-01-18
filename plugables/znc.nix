{ config, pkgs, lib, ... }:

{
  services.znc = {
    enable = true;
    mutable = true;
    openFirewall = true;
    confOptions = {
      # Basics
      port = 6667;
      useSSL = false;
      nick = "leotaku";
      userName = "leotaku";
      passBlock = ''
      <Pass password>
        Method = sha256
        Hash = 4d1f02701e27fee1405d52527bc93f9ad8e233a0946f1bc86ea540edeb176af7
        Salt = 9vpyWS6!(5wkCR3uv:_5
       </Pass>
      '';
      # Networks
      networks = {
        freenode = {
          server = "irc.freenode.net";
          useSSL = true;
          modules = [ "sasl" ];
        };
        irchighway = {
          server = "irc.irchighway.net";
          useSSL = true;
        };

      };
      # Other
      modules = [ "adminlog" "dcc" ];
      extraZncConf = ''
        MaxBufferSize=50000
      '';
    };
  };
}
