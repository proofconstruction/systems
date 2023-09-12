{ config
, pkgs
, lib
, ...
}:
{
  options.mine.vlc.enable = lib.mkEnableOption "VLC Media Player";

  config = lib.mkIf config.mine.vlc.enable {
    home-manager.users.${config.mine.user.name}.home.packages = [ pkgs.vlc ];
  };
}
