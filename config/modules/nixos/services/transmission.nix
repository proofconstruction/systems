{ config
, lib
, pkgs
, ...
}:

{
  options.mine.transmission.enable = lib.mkEnableOption "transmission";

  config = lib.mkIf config.mine.transmission.enable {
    services = {
      transmission = {
        enable = true;
        package = pkgs.transmission_4;
        webHome = pkgs.flood-for-transmission;
        settings = {
          rpc-port = 9091;
          rpc-bind-address = "127.0.0.1";
          download-dir = "/media/downloads/complete";
          incomplete-dir = "/media/downloads/incomplete";
          message-level = 6;
        };
      };

      caddy = {
        virtualHosts."transmission.${config.networking.domain}" = {
          useACMEHost = config.networking.domain;
          extraConfig = ''
            reverse_proxy http://localhost:${toString config.services.transmission.settings.rpc-port}
          '';
        };
      };
    };
  };
}
