{ config, pkgs, lib, ... }:

{
  environment.systemPackages = [
    config.boot.kernelPackages.perf
  ];

  boot.kernel.sysctl = {
    "kernel.perf_event_paranoid" = -1;
    "kernel.kptr_restrict" = 0;
  };
}
