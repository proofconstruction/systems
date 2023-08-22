{ config
, pkgs
, lib
, ...
}:

{
  options.mine.nix-serve.enable = lib.mkEnableOption "nix-serve";

  config = lib.mkIf config.mine.nix-serve.enable {
    services = {
      nix-serve = {
        enable = true;
        secretKeyFile = "/var/cache-priv-key.pem";
      };

      caddy = {
        enable = true;
        virtualHosts."base.${config.private.personal.homeDomain}".extraConfig = ''
          reverse_proxy http://${config.services.nix-serve.bindAddress}:${toString config.services.nix-serve.port}
        '';
      };
    };
  };
}
