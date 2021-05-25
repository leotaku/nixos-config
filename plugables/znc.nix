{ config, pkgs, lib, ... }:

{
  services.znc = {
    enable = true;
    useLegacyConfig = false;
    mutable = true;
    config = {
      LoadModule = [ "adminlog" "fail2ban" ];
      MaxBufferSize = 1000;
      Listener.l = {
        Port = 6667;
        SSL = false;
      };
      User.leotaku = {
        LoadModule = [ "chansaver" "dcc" ];
        AutoClearChanBuffer = false;
        Admin = true;
        Nick = "leotaku";
        AltNick = "le0taku";
        Network.freenode = {
          LoadModule = [ "sasl" ];
          Server = "chat.freenode.net";
          SSL = true;
        };
        Network.libera = {
          LoadModule = [ "sasl" ];
          Server = "irc.libera.chat";
          SSL = true;
        };
        Network.irchighway = {
          Server = "irc.irchighway.net";
          SSL = true;
        };
        Pass.password = {
          Method = "sha256";
          Hash = "4ad4a22a92eb784a6f115a833116ac11f373fe78830243b7ec8db007b99ec645";
          Salt = "Wa3qDwgHHP()IIVm(C9U";
        };
      };
    };
  };
}
