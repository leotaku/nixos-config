{ config, pkgs, lib, ... }:
{
  services.znc = {
    enable = true;
    mutable = false;
    openFirewall = true;
    confOptions = {
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
      networks = {
        freenode = {
          port = 6697; 
          server = "chat.freenode.net"; 
          useSSL = true;
          channels = [ "nixos" ];
          modules = [ "sasl" ];
        };
        rizon = {
          port = 6697;
          server = "irc.rizon.net";
          useSSL = true;
        };
        unix = {
          port = 6697;
          server = "unix.chat";
          useSSL = true;
        };
        irchighway = {
          port = 6697;
          server = "irc.irchighway.net";
          useSSL = true;
        };

      };
      extraZncConf = ''
        MaxBufferSize=10000
      '';
    };
  };
}
