{ config, pkgs, lib, ... }: {
  
  imports = [
    ../hardware/raspberry3.nix
    ../plugables/builders/default.nix
    ../plugables/packages/base.nix
    ../plugables/avahi/default.nix
  ];

  # IMPORTANT: removing this causes avahi to fail
  networking.hostName = "nixos-rpi";

  # Nixpkgs configurations
  nixpkgs = rec {
    # Tell the host system that it can, and should, build for aarch64.    
    crossSystem = lib.systems.elaborate {
      config = "aarch64-unknown-linux-gnu";
    };
    localSystem = crossSystem;
    overlays = [];      
  };
  
  nix.trustedUsers = [ "root" "remote-builder" ];

  users.extraUsers.remote-builder = {
    isNormalUser = true;
    shell = pkgs.bash;
  };

  environment.systemPackages = with pkgs; [ hello ];

  # netdata monitoring
  services.nginx = {
    enable = true;
    package = pkgs.nginxMainline;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts = {
      "localhost" = {
        locations = { "/".proxyPass = "http://localhost:19999/"; };
      };
    };
  };

  services.netdata.enable = true;

  # udisks depends on gtk+ which I don't want on my headless servers
  services.udisks2.enable = false;

  services.openssh.enable = true;
  services.openssh.permitRootLogin = "yes";

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
}
