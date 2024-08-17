{ config
, pkgs
, lib
, ...
}:

{
  options.custom.nix-serve.enable = lib.mkEnableOption "nix-serve";

  config = lib.mkIf config.custom.nix-serve.enable {
    services = {
      nix-serve = {
        enable = true;
        secretKeyFile = "/var/cache-priv-key.pem";
      };

      caddy = {
        enable = true;
        virtualHosts."cache.${config.private.homelab.domain}".extraConfig = ''
          reverse_proxy http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}
        '';
      };
    };
  };
}
