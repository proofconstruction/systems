{ config
, lib
, ...
}:

{
  options.custom.rtorrent.enable = lib.mkEnableOption "rtorrent";

  config = lib.mkIf config.custom.rtorrent.enable {
    home-manager.users.${config.custom.user.name}.programs.rtorrent.enable = true;
  };
}
