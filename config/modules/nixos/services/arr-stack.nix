{ config
, lib
, ...
}:

let
  sonarr_port = 8989;
  bazarr_port = 6767;
  radarr_port = 7878;
  readarr_port = 8787;
  lidarr_port = 8686;
  prowlarr_port = 9696;
in
{
  options.custom.arr-stack.enable = lib.mkEnableOption "the -arr stack";

  config = lib.mkIf config.custom.arr-stack.enable {
    services = {
      sonarr.enable = true;
      radarr.enable = true;
      bazarr.enable = true;
      readarr.enable = true;
      lidarr.enable = true;
      prowlarr.enable = true;

      caddy = {
        enable = true;
        virtualHosts."sonarr.${config.networking.domain}" = {
          useACMEHost = config.networking.domain;
          extraConfig = ''
            reverse_proxy http://localhost:${toString sonarr_port}
          '';
        };
        virtualHosts."radarr.${config.networking.domain}" = {
          useACMEHost = config.networking.domain;
          extraConfig = ''
            reverse_proxy http://localhost:${toString radarr_port}
          '';
        };
        virtualHosts."bazarr.${config.networking.domain}" = {
          useACMEHost = config.networking.domain;
          extraConfig = ''
            reverse_proxy http://localhost:${toString bazarr_port}
          '';
        };
        virtualHosts."readarr.${config.networking.domain}" = {
          useACMEHost = config.networking.domain;
          extraConfig = ''
            reverse_proxy http://localhost:${toString readarr_port}
          '';
        };
        virtualHosts."lidarr.${config.networking.domain}" = {
          useACMEHost = config.networking.domain;
          extraConfig = ''
            reverse_proxy http://localhost:${toString lidarr_port}
          '';
        };
        virtualHosts."prowlarr.${config.networking.domain}" = {
          useACMEHost = config.networking.domain;
          extraConfig = ''
            reverse_proxy http://localhost:${toString prowlarr_port}
          '';
        };
      };
    };
  };
}
