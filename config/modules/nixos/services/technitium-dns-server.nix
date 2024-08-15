{ config
, lib
, ...
}:

let
  fqdn = "dns.${config.networking.domain}";
  port = 5380;
in
{
  options.mine.technitium-dns-server.enable = lib.mkEnableOption "technitium-dns-server";

  config = lib.mkIf config.mine.technitium-dns-server.enable {
    services.technitium-dns-server.enable = true;

    services.caddy = {
      enable = true;
      virtualHosts.${fqdn} = {
        useACMEHost = config.networking.domain;
        extraConfig = ''
          reverse_proxy http://localhost:${toString port}
        '';
      };
    };
  };
}
