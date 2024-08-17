{ config
, pkgs
, lib
, ...
}:
{
  options.custom.vlc.enable = lib.mkEnableOption "VLC Media Player";

  config = lib.mkIf config.custom.vlc.enable {
    home-manager.users.${config.custom.user.name}.home.packages = [ pkgs.vlc ];
  };
}
