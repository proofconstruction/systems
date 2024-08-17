{ config
, lib
, ...
}:

let
  cfgp = config.private.homelab.acme;
in
{
  options.custom.acme.enable = lib.mkEnableOption "acme";

  config = lib.mkIf config.custom.acme.enable {
    security.acme = {
      acceptTerms = true;
      preliminarySelfsigned = true;
      defaults = {
        email = cfgp.cert-email;
        server = cfgp.letsencrypt.staging;
        dnsProvider = cfgp.dnsProvider;
        credentialFiles = cfgp.credentialFiles;
      };
      certs.${config.networking.domain} = {
        extraDomainNames = [ "*.${config.networking.domain}" ];
        dnsPropagationCheck = true;
        server = cfgp.letsencrypt.production;
        dnsProvider = cfgp.dnsProvider;
        credentialFiles = cfgp.credentialFiles;
      };
    };

    # let caddy proxy read the certs
    users.users.caddy.extraGroups = [ "acme" ];

    # permit the DNS-01 challenge
    networking.firewall.allowedTCPPorts = [
      53
    ];
  };
}
