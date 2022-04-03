{ config, pkgs, lib, ... }:

let
  nginxCustom = pkgs.nginxMainline.override
    (old: { modules = with pkgs.nginxModules; [ fancyindex ]; });
  protectHost = _: v:
    (sslHost _ v) // {
      basicAuthFile = builtins.toString /var/keys/htpasswd;
    };
  sslHost = _: v:
    v // {
      useACMEHost = "le0.gs";
      forceSSL = true;
    };
  trackingConfig = ''
    sub_filter '</body>' '<script data-goatcounter="https://analytics.le0.gs/count" async src="//analytics.le0.gs/count.js"></script></body>';
    sub_filter_once on;
  '';
in {
  # Nginx server
  services.nginx = {
    enable = true;
    package = nginxCustom;

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
            extraConfig = trackingConfig + ''
              error_page 404 /404.html;
            '';
          };
          "/public".return = "301 /public/";
          "/public/" = {
            alias = "/var/web/public/";
            extraConfig = trackingConfig + ''
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
      "rss.le0.gs" = {
        locations = { "/" = { proxyPass = "http://localhost:1270/"; }; };
      };
      "analytics.le0.gs" = {
        locations = { "/" = { proxyPass = "http://localhost:9000/"; }; };
      };
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
      "tv.le0.gs" = {
        locations = {
          "/" = {
            proxyPass = "http://localhost:8989";
            extraConfig = ''
              proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_redirect off;
              sub_filter '</head>' '<link rel="stylesheet" type="text/css" href="https://archmonger.github.io/Blackberry-Themes/Themes/Blackberry-Shadow/radarr.css"></head>';
              sub_filter_once on;
            '';
          };
        };
      };
      "download.le0.gs" = {
        locations = {
          "/".root = pkgs.fetchzip {
            url =
              "https://github.com/mayswind/AriaNg/releases/download/1.2.1/AriaNg-1.2.1.zip";
            sha256 = "19ing17sq541j0yd27n1m1x7vjc8dwjg9gb02qhi8ncmvq73x5jw";
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
  users.users."nginx".extraGroups = [ "acme" ];

  # Acme certificates
  security.acme = {
    acceptTerms = true;
    certs = {
      "le0.gs" = {
        email = "leo.gaskin@le0.gs";
        webroot = config.services.nginx.virtualHosts."le0.gs".acmeRoot;
        extraDomainNames = lib.filter (n: n != "le0.gs")
          (lib.attrNames config.services.nginx.virtualHosts);
        group = "acme";
      };
    };
  };

  # GoatCounter analytics
  systemd.services."goatcounter" = {
    serviceConfig = {
      WorkingDirectory = "/var/lib/goatcounter";
      ExecStart = pkgs.goatcounter
        + "/bin/goatcounter serve -listen :9000 -tls none";
      Type = "simple";
    };
    after = [ "nginx.service" ];
    wantedBy = [ "default.target" ];
  };

  # Cloudflare DNS updates
  systemd.services."cloudflare-dns" = {
    path = with pkgs; [ bash curl dnsutils jq ];
    serviceConfig = {
      EnvironmentFile = builtins.toString /var/keys/cloudflare.env;
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
