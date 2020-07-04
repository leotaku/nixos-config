{ config, pkgs, lib, ... }:

{
  # Netdata configuration
  services.netdata.enable = true;
  services.netdata.config = {
    "global" = {
      "debug log" = "syslog";
      "access log" = "syslog";
      "error log" = "syslog";
      "dbengine disk space" = "1100";
    };
  };
}
