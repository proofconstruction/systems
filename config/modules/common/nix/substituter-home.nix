{ config
, lib
, ...
}:

let
  cfg = config.personal.homeDomain;
  notBase = config.networking.hostName != "base";
in
{
  options.custom.nix.caches = with lib; {
    home.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable the binary cache served by base.
      '';
    };
  };


  config = lib.mkIf (config.custom.nix.caches.home.enable && notBase) {
    nix.settings = {
      substituters = [ "http://cache.${cfg}" ];
      trusted-public-keys = [
        "cache.${cfg}:kEdj9tgHGxd4fcBWlxmpdD9M8JvyCGGb97pJa34Xiac="
      ];
    };
  };
}
