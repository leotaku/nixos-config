{
  network = {
    description = "RPI3 Server";
    enableRollback = true;
    pkgs = (import ../sources/links/nixos-19_03 {
      system = "aarch64-linux";
      config.allowBroken = false;
      overlays = [
        (self: super: {
          openjpeg = super.openjpeg.override { testsSupport = false; };
        })
      ];
    });
  };

  "nixos-rpi.local" = { config, pkgs, ... }: {
    imports = [
      ../hardware/raspberry3.nix
      ../plugables/packages/base.nix
      ../plugables/avahi/default.nix
    ];

    # IMPORTANT: removing this causes avahi to fail
    networking.hostName = "nixos-rpi";

    # Nixpkgs configurations
    nixpkgs.localSystem.system = "aarch64-linux";
    nixpkgs.overlays = [];
    
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

    #boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
