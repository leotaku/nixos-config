{
  network.description = "RPI3 Server";
  network.enableRollback = true;

  nixos-rpi =
    { config, pkgs, ... }:
    { 
      imports = [
        ../hardware/raspberry3.nix
        ../modules/dns-records.nix
        ../plugables/avahi/default.nix
        ../plugables/znc/default.nix
      ];

      services.dns-records-update = {
        enable = true;
        timer = "01:00:00";
        urls = {
          "le0.gs" = "https://api.1984.is/1.0/freedns/?apikey=l5Ux3Xl7Pi0Mo7Tg4Ad5Rg3Xn6Pp9Pf7Wi3Ul3Sk2Nx6Ll0Xq2To5Fl8Tl0Tb1K&domain=le0.gs&ip=";
          "test.le0.gs" = "https://api.1984.is/1.0/freedns/?apikey=l5Ux3Xl7Pi0Mo7Tg4Ad5Rg3Xn6Pp9Pf7Wi3Ul3Sk2Nx6Ll0Xq2To5Fl8Tl0Tb1K&domain=test.le0.gs&ip=";
        };
      };

      nix.trustedUsers = [ "root" "remote-builder" ];

      users.extraUsers.remote-builder = {
        isNormalUser = true;
        shell = pkgs.bash;
      };

      environment.systemPackages = with pkgs; [
        htop
        ncdu
        nix-top
      ];

      services.nginx = {
        enable = true;
        package = pkgs.nginxMainline;

      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

        virtualHosts = {
          "le0.gs" = {
            enableACME = true;
            #useACMEHost = "le0.gs";
            #addSSL = true;
            forceSSL = true;
            root = "${pkgs.callPackage ./site/default.nix {}}/";
          };
          "test.le0.gs" = {
            enableACME = true;
            #useACMEHost = "le0.gs";
            #addSSL = true;
            forceSSL = true;
            locations = {
              "/".proxyPass = "http://localhost:19999/";
            };
          };
        };
      };

      services.netdata.enable = true;

      #security.acme.certs = {
      #  "le0.gs" = { 
      #    email = "leo.gaskin@brg-feldkirchen.at";
      #    webroot = "/var/lib/acme/acme-challenges";
      #    extraDomains = {
      #      "le0.gs" = null;
      #      "test.le0.gs" = null;
      #    };
      #    postRun = "systemctl restart nginx.service";
      #  };
      #};

      services.openssh.enable = true;
      services.openssh.permitRootLogin = "yes";

      services.avahi.enable = true;

      networking.firewall.enable = true;
      networking.firewall.allowedTCPPorts = [ 22 80 443 6667 ];

      deployment.targetHost = "nixos-rpi.local";
      #deployment.targetHost = "192.168.178.23";

      # boot.kernelPackages = pkgs.linuxPackages_latest;
      nixpkgs.system = "aarch64-linux";
      nixpkgs.config.allowBroken = false;
    };
}
