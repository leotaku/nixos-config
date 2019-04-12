# !!! WARNING !!!
# this isn't working yet
# !!! WARNING !!!

{ config, pkgs, ... }:
{
  imports = [
    #../../sources/links/simple-nixos-mailserver
  ];

  mailserver = {
    enable = false;
    fqdn = "mail.le0.gs";
    domains = [ "le0.gs" ];
    loginAccounts = {
        "leo@le0.gs" = {
            hashedPassword = "$6$/z4n8AQl6K$kiOkBTWlZfBd7PvF5GsJ8PmPgdZsFGN1jPGZufxxr60PoR0oUsrvzm2oQiflyz5ir9fFJ.d/zKm/NgLXNUsNX/";
  
            aliases = [
                "info@example.com"
                "postmaster@example.com"
                "postmaster@example2.com"
            ];
        };
    };
  
    # Use Let's Encrypt certificates. Note that this needs to set up a stripped
    # down nginx and opens port 80.
    # certificateScheme = 3;
  
    # Enable IMAP and POP3
    enableImap = true;
    enablePop3 = true;
    enableImapSsl = true;
    enablePop3Ssl = true;
  
    # Enable the ManageSieve protocol
    enableManageSieve = true;
  
    # whether to scan inbound emails for viruses (note that this requires at least
    # 1 Gb RAM for the server. Without virus scanning 256 MB RAM should be plenty)
    virusScanning = true;
  };
}
