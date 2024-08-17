{ config
, lib
, ...
}:

let
  fqdn = "git.${config.networking.domain}";
in
{
  options.custom.forgejo.enable = lib.mkEnableOption "forgejo";

  config = lib.mkIf config.custom.forgejo.enable {
    services = {
      forgejo = {
        enable = true;

        settings = {
          DEFAULT = {
            APP_NAME = "${fqdn}: Forgejo Service";
          };

          server = {
            DOMAIN = fqdn;
          };
        };
      };

      caddy = {
        enable = true;
        virtualHosts.${fqdn} = {
          useACMEHost = config.networking.domain;
          extraConfig = ''
            reverse_proxy http://localhost:${toString config.services.forgejo.settings.server.HTTP_PORT}
          '';
        };
      };
    };

    # make sure we can git clone with ssh
    networking.firewall.allowedTCPPorts = [
      22
      80
      443
    ];
  };
}

