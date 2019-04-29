{
  network.description = "Fujitsu Server";
  network.enableRollback = true;

  nixos-fujitsu =
    { config, pkgs, ... }:
    { 
      imports = [
        ../hardware/fujitsu.nix
        ../modules/dns-records.nix
        ../plugables/avahi/default.nix
        ../plugables/znc/default.nix
        ../private/dns.nix
        ../sources/external/clever/qemu.nix
      ];

      qemu-user.aarch64 = true;

      nix.trustedUsers = [ "root" "remote-builder" ];

      users.extraUsers.remote-builder = {
        isNormalUser = true;
        shell = pkgs.bash;
      };

      environment.systemPackages = with pkgs; [
        htop
        ncdu
        nix-top
        vim
        speedtest-cli
        fd
        ripgrep
        iperf
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
            locations = {
              "/".root = "${pkgs.callPackage ./site/default.nix {}}/";
              "/rustdoc" = {
                root = "/var/web/";
                index = "settings.html";
              };

              #extraConfig = "autoindex on;";
            };
          };
          "test.le0.gs" = {
            enableACME = true;
            addSSL = true;
            globalRedirect = "vwa.le0.gs";
          };
          "vwa.le0.gs" = {
            enableACME = true;
            forceSSL = true;
            locations = {
              "/".root = "/var/web/hugo/public";
            };
          };
          "restic.le0.gs" = {
            enableACME = true;
            forceSSL = true;
            locations = {
              "/".root = "/var/web/restic";
            };
          };
          "stats.le0.gs" = {
            enableACME = true;
            forceSSL = true;
            locations = {
              "/".proxyPass = "http://localhost:19999/";
            };
          };
        };
      };

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
      
      services.restic.server = {
        enable = true;
        prometheus = true;
      };

      services.netdata.enable = true;

      services.haveged.enable = true;

      # udisks depends on gtk+ which I don't want on my headless servers
      services.udisks2.enable = false;

      services.openssh.enable = true;
      services.openssh.permitRootLogin = "yes";

      services.avahi.enable = true;

      networking.firewall.enable = true;
      networking.firewall.allowedTCPPorts = [ 22 80 443 6667 8000 ];

      deployment.targetHost = "nixos-fujitsu.local";
      #deployment.targetHost = "192.168.178.40";
       
      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowBroken = false;

    };
}
