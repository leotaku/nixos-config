{ config, pkgs, lib, ... }:

{
  # Aria2 server
  services.aria2 = {
    enable = true;
    downloadDir = config.fileSystems.raid1x5tb.mountPoint + "/download";
    listenPortRange = map (n: { from = n; to = n; }) [ 16302 22751 7260 ];
    openPorts = false;
    extraArguments = lib.concatStringsSep " " [
      "--rpc-listen-all=false"
      "--remote-time=true"
      "--max-concurrent-downloads=200"
      "--save-session-interval=30"
      "--force-save=true"
      "--input-file=/var/lib/aria2/aria2.session"
      "--enable-dht=true"
      "--dht-listen-port=25776"
      "--seed-ratio=3.0"
    ];
    # NOTE: Irrelevant, we are protected by http-auth
    rpcSecret = "aria2rpc";
  };

  # User IDs for networking tables
  users.users."aria2".uid = lib.mkForce 1001;

  # Special networking tables config
  systemd.services."torrenting-rules" = {
    path = with pkgs; [ iproute ];
    serviceConfig = {
      ExecStart = pkgs.writeShellScript "setup-rules" ''
        ip rule add to 10.0.0.0/8 table main priority 1000
        ip rule add sport 6800 table main priority 1000
        ip rule add uidrange 1001-1001 table 2002 priority 1001
        ip rule add blackhole uidrange 1001-1001 priority 1002
        ip route flush cache
      '';
      ExecStop = pkgs.writeShellScript "teardown-rules" ''
        ip rule del to 10.0.0.0/8 table main
        ip rule del sport 6800 table main
        ip rule del uidrange 1001-1001 table 2002
        ip rule del blackhole uidrange 1001-1001
        ip route flush cache
      '';
      RemainAfterExit = true;
      Type = "simple";
    };
    requires = [ "network.target" ];
    requiredBy = [ "aria2.service" ];
    before = [ "aria2.service" ];
  };
}
