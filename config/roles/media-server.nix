{ config
, lib
, ...
}:

{
  options.roles.media-server = lib.mkEnableOption "Media server";

  config = lib.mkIf config.roles.media-server {
    custom = {
      jellyfin.enable = true;
      polaris.enable = true;
    };
  };
}
