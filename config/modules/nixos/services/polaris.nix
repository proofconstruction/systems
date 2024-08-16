{ config
, lib
, ...
}:

let
  fqdn = "music.${config.networking.domain}";
  port = 5050;
in
{
  options.custom.polaris.enable = lib.mkEnableOption "polaris";

  config = lib.mkIf config.custom.polaris.enable {
    services = {
      polaris = {
        enable = true;
        inherit port;
      };

      caddy = {
        enable = true;
        virtualHosts.${fqdn} = {
          useACMEHost = config.networking.domain;
          extraConfig = ''
            reverse_proxy http://localhost:${toString port}
          '';
        };
      };
    };
  };
}
