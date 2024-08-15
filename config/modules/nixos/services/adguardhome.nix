{ config
, lib
, pkgs
, ...
}:

let
  fqdn = "dns.${config.networking.domain}";
  cfgp = config.private.homelab.acme;
in
{
  options.mine.adguardhome.enable = lib.mkEnableOption "adguardhome";

  config = lib.mkIf config.mine.adguardhome.enable {
    services = {
      adguardhome = {
        enable = true;
        port = 5380;
        mutableSettings = false;
        settings = {
          http = "127.0.0.1:${toString config.services.adguardhome.port}";
          dns = {
            bootstrap_dns = [
              "9.9.9.9"
              "8.8.8.8"
              "1.1.1.1"
            ];
          };
        };
        allowDHCP = false;
      };

      caddy = {
        enable = true;
        virtualHosts.${fqdn} = {
          useACMEHost = config.networking.domain;
          extraConfig = ''
            reverse_proxy http://localhost:${toString config.services.adguardhome.port}
          '';
        };
      };
    };
  };
}
