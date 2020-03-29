{ config, pkgs, lib, ... }:

let
  nginx = pkgs.nginxMainline.override (old: {
    modules = with pkgs.nginxModules; [
      fancyindex
    ];
  });
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
              # proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_set_header X-Forwarded-Protocol $scheme;
              proxy_set_header X-Forwarded-Host $http_host;

              # Disable buffering when the nginx proxy gets very resource heavy upon streaming
              proxy_buffering off;
            '';
          };
          "/socket" = {
            proxyPass = "http://localhost:8096/socket";
            extraConfig = ''
              proxy_http_version 1.1;
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection "upgrade";
              proxy_set_header Host $host;
              proxy_set_header X-Real-IP $remote_addr;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header X-Forwarded-Proto $scheme;
              proxy_set_header X-Forwarded-Protocol $scheme;
              proxy_set_header X-Forwarded-Host $http_host;
            '';
          };
        };
      };
      "aria2.le0.gs" = {
        locations = {
          "/" = let
            webui-aria2 = pkgs.fetchFromGitHub {
              repo = "webui-aria2";
              owner = "ziahamza";
              rev = "fb9d758d5cdc2be0867ee9502c44fd17560f5d24";
              sha256 = "0law0yiqlhc48cmc2195x7ih27zpspav0njjpk79w0n7i5knjs6n";
            };
          in { root = webui-aria2 + "/docs/"; };
          "/jsonrpc" = {
            proxyPass = "http://localhost:6800/jsonrpc";
            extraConfig = ''
              proxy_http_version 1.1;
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection "Upgrade";
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

  # NOTE: The keys group is used only for NixOps compatibility
  users.users.nginx.extraGroups = [ "keys" "syncthing" ];

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

  # Cloudflare DNS service
  systemd.services."cloudflare-dns" = {
    path = with pkgs; [ bash curl dnsutils jq ];
    serviceConfig = {
      ExecStart = pkgs.bash + "/bin/bash ${../private/update-dns.sh}";
      Type = "simple";
    };
    requires = [ "network.target" ];
    wantedBy = [ "default.target" ];
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
