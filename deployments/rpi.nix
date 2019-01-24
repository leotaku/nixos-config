{
  network.description = "RPI3 Server";
  network.enableRollback = true;

  nixos-rpi =
    { config, pkgs, ... }:
    { 
      imports = [
        ../hardware/raspberry3.nix
        ../plugables/avahi/default.nix
        ../plugables/znc/default.nix
      ];

      nix.trustedUsers = [ "root" "remote-builder" ];

      users.extraUsers.remote-builder = {
        isNormalUser = true;
        shell = pkgs.bash;
      };

      environment.systemPackages = with pkgs; [
        htop
        ncdu
        nix-top
        speedtest-cli
      ];

      services.nginx = {
        enable = true;
        package = pkgs.nginxMainline;

        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        
        virtualHosts = {
          "localhost" = {
            locations = {
              "/".proxyPass = "http://localhost:19999/";
            };
          };
        };
      };

      services.netdata.enable = true;

      services.openssh.enable = true;
      services.openssh.permitRootLogin = "yes";

      services.avahi.enable = true;

      networking.firewall.enable = true;
      networking.firewall.allowedTCPPorts = [ 22 80 443 ];

      deployment.targetHost = "nixos-rpi.local";
      #deployment.targetHost = "192.168.178.23";

      # boot.kernelPackages = pkgs.linuxPackages_latest;
      nixpkgs.system = "aarch64-linux";
      nixpkgs.config.allowBroken = false;
    };
}
