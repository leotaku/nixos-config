{ config, pkgs, lib, ... }:
{
  services.znc = {
    enable = true;
    mutable = true;
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
      networks.freenode = {
        port = 6697; 
        server = "chat.freenode.net"; 
        useSSL = true;
        channels = [ "nixos" ];
        modules = [ "simple_away" ];
      };
      extraZncConf = ''
        MaxBufferSize=10000
      '';
    };
  };
}
