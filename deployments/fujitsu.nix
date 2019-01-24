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
        ../private/dns.nix
        #../sources/links/libs/simple-nixos-mailserver/default.nix
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
        vim
        speedtest-cli
        fd
        ripgrep
      ];

      services.haveged.enable = true;

      services.restic.server = {
        enable = true;
        prometheus = true;
      };

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
            forceSSL = true;
            locations = {
              "/".root = "/var/web/hugo/public";
            };
          };
          "restic.le0.gs" = {
            enableACME = true;
            forceSSL = true;
            locations = {
              "/".proxyPass = "http://localhost:8000/";
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
      
      services.netdata.enable = true;

      # mailserver = {
      #   enable = false;
      #   fqdn = "mail.le0.gs";
      #   domains = [ "le0.gs" ];
      #   loginAccounts = {
      #       "leo@le0.gs" = {
      #           hashedPassword = "$6$/z4n8AQl6K$kiOkBTWlZfBd7PvF5GsJ8PmPgdZsFGN1jPGZufxxr60PoR0oUsrvzm2oQiflyz5ir9fFJ.d/zKm/NgLXNUsNX/";
    
      #           aliases = [
      #               "info@example.com"
      #               "postmaster@example.com"
      #               "postmaster@example2.com"
      #           ];
      #       };
      #   };

      #   # Use Let's Encrypt certificates. Note that this needs to set up a stripped
      #   # down nginx and opens port 80.
      #   # certificateScheme = 3;

      #   # Enable IMAP and POP3
      #   enableImap = true;
      #   enablePop3 = true;
      #   enableImapSsl = true;
      #   enablePop3Ssl = true;

      #   # Enable the ManageSieve protocol
      #   enableManageSieve = true;

      #   # whether to scan inbound emails for viruses (note that this requires at least
      #     # 1 Gb RAM for the server. Without virus scanning 256 MB RAM should be plenty)
      #   virusScanning = true;
      # };
      
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
