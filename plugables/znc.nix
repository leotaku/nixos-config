{ config, pkgs, lib, ... }:

{
  services.znc = {
    enable = true;
    useLegacyConfig = false;
    mutable = true;
    config = {
      LoadModule = [ "adminlog" ];
      MaxBufferSize = 50000;
      Listener.l = {
        Port = 6667;
        SSL = false;
      };
      User.leotaku = {
        LoadModule = [ "dcc" ];
        Admin = true;
        Nick = "leotaku";
        Network.freenode = {
          LoadModule = [ "sasl" ];
          Server = "chat.freenode.net";
          SSL = true;
        };
        Network.irchighway = {
          Server = "irc.irchighway.net";
          SSL = true;
        };
        Pass.password = {
          Method = "sha256";
          Hash = "4d1f02701e27fee1405d52527bc93f9ad8e233a0946f1bc86ea540edeb176af7";
          Salt = "9vpyWS6!(5wkCR3uv:_5";
        };
      };
    };
  };
}
