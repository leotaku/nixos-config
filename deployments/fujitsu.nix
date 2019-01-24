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
      ];
      
      services.netdata.enable = true;

      services.openssh.enable = true;
      services.openssh.permitRootLogin = "yes";

      services.avahi.enable = true;

      networking.firewall.enable = true;
      networking.firewall.allowedTCPPorts = [ 22 80 443 6667 19999 ];

      deployment.targetHost = "nixos-fujitsu.local";
      #deployment.targetHost = "192.168.178.40";
       
      # nixpkgs.system = "aarch64-linux";
      nixpkgs.config.allowBroken = false;

    };
}
