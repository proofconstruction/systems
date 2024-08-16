{ config
, lib
, ...
}:

let
  fqdn = "media.${config.networking.domain}";
  port = 8096;
in
{
  options.custom.jellyfin.enable = lib.mkEnableOption "jellyfin";

  config = lib.mkIf config.custom.jellyfin.enable {
    services = {
      jellyfin = {
        enable = true;
        openFirewall = true;
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
