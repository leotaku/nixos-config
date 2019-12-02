{ config, pkgs, lib, ... }:

{
  services.postfix = {
    enable = true;
    config = {
      myorigin = "$mydomain";
      #mynetworks = 127.0.0.0/8
      mynetworks_style = "host";

      smtp_sender_dependent_authentication = true;
      #relayhost = "[smtp.outlook.com]:587";
      #smtp_sasl_password_maps = "hash:/etc/nixos/nixos-config/private/postfix/sasl_password_map_default";
      # This has to match "pass_map_file" in ./home-manager.nix
      smtp_sasl_password_maps = "hash:/etc/nixos/nixos-config/private/postfix/sasl_password_maps";
      sender_dependent_relayhost_maps = "hash:/etc/nixos/nixos-config/private/postfix/sender_relay_maps";

      # SASL SUPPORT FOR SERVERS
      #
      # The following options set parameters needed by Postfix to enable
      # Cyrus-SASL support for authentication of mail servers.
      
      smtp_always_send_ehlo = true;
      smtp_sasl_auth_enable = "yes";
      smtp_sasl_security_options = "noanonymous";
      smtp_sasl_mechanism_filter = "plain, login";
      
      smtpd_sasl_auth_enable = "no";
      #smtpd_sasl_path = "smtpd";
      #smtpd_sasl_security_options = "noanonymous";
      #smtpd_sasl_password_maps = "hash:/path/to/file";
      #smtpd_sasl_mechanism_filter = "plain, login";

      smtp_use_tls = "yes";
      smtp_tls_security_level = "encrypt";
      smtpd_use_tls = "no";

    }; 
  }; 
}
