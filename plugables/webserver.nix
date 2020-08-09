{ config, pkgs, lib, ... }:

let
  nginx = pkgs.nginxMainline.override
    (old: { modules = with pkgs.nginxModules; [ fancyindex ]; });
  protectHost = _: v:
    (sslHost _ v) // {
      basicAuthFile = config.deployment.secrets."htpasswd".destination;
    };
  sslHost = _: v:
    v // {
      useACMEHost = "le0.gs";
      forceSSL = true;
    };
in {
  # Nginx server
  services.nginx = {
    enable = true;
    package = nginx;

    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    # Always use UTF-8
    appendHttpConfig = "charset utf-8;";

    virtualHosts = lib.mapAttrs sslHost {
      "le0.gs" = {
        locations = {
          "/" = {
            root = "/var/web/site";
            extraConfig = "error_page 404 /404.html;";
          };
          "/public".return = "301 /public/";
          "/public/" = {
            alias = "/var/web/stuff/public/";
            extraConfig = ''
              fancyindex on;
              fancyindex_exact_size off;
            '';
          };
        };
      };
      "raw.le0.gs" = {
        locations = {
          "/robots.txt" = {
            return = ''200 "User-agent: *\nDisallow: /\n"'';
            extraConfig = "add_header Content-Type text/plain;";
          };
        };
      };
      "stats.le0.gs" = {
        locations = {
          "/".return = "301 /fujitsu/";
          "/fujitsu".proxyPass = "http://localhost:19999/";
          "/rpi".proxyPass = "http://nixos-rpi.local/";
        };
      };
      "rss.le0.gs" = { };
    } // lib.mapAttrs protectHost {
      "files.le0.gs" = {
        locations = {
          "/" = {
            alias = "/var/web/stuff/";
            extraConfig = ''
              fancyindex on;
              fancyindex_exact_size off;
            '';
          };
        };
      };
      "stream.le0.gs" = {
        locations = {
          "/" = {
            proxyPass = "http://localhost:8096/";
            extraConfig = ''
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_set_header X-Forwarded-Protocol $scheme;
              proxy_set_header X-Forwarded-Host $http_host;
              proxy_buffering off;
            '';
          };
          "/socket" = {
            proxyPass = "http://localhost:8096/socket/";
            extraConfig = ''
              proxy_http_version 1.1;
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection "upgrade";
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_set_header X-Forwarded-Protocol $scheme;
              proxy_set_header X-Forwarded-Host $http_host;
            '';
          };
        };
      };
      "download.le0.gs" = {
        locations = {
          "/".root = pkgs.fetchzip {
            url =
              "https://github.com/mayswind/AriaNg/releases/download/1.1.5/AriaNg-1.1.5.zip";
            sha256 = "1j0899i35yz97f7q74vylg3bk9ipnr8842g80azs67xsf007lj4y";
            stripRoot = false;
          };
          "/jsonrpc" = {
            proxyPass = "http://localhost:6800/jsonrpc";
            extraConfig = ''
              proxy_http_version 1.1;
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection "upgrade";
              proxy_set_header Host $host;
              proxy_set_header X-Forwarded-Host $host:$server_port;
              proxy_set_header X-Forwarded-Server $host;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            '';
          };
        };
      };
    };
  };

  # Nginx server may access personal files
  users.users.nginx.extraGroups = [ "syncthing" ];

  # Acme certificates
  security.acme = {
    acceptTerms = true;
    certs = {
      "le0.gs" = {
        email = "leo.gaskin@brg-feldkirchen.at";
        webroot = config.services.nginx.virtualHosts."le0.gs".acmeRoot;
        extraDomains = lib.filterAttrs (n: _: n != "le0.gs")
          (lib.mapAttrs (n: _: null) config.services.nginx.virtualHosts);
        user = "nginx";
        group = "nginx";
      };
    };
  };

  # Cloudflare DNS updates
  systemd.services."cloudflare-dns" = {
    path = with pkgs; [ bash curl dnsutils jq ];
    serviceConfig = {
      EnvironmentFile = config.deployment.secrets."cloudflare.env".destination;
      ExecStart = "${../files/update-dns.sh}";
      Type = "simple";
    };
    requires = [ "network.target" ];
  };

  systemd.timers."cloudflare-dns" = {
    enable = true;
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = [ "*:0/05" ];
      Persistent = true;
    };
  };
}
