{ config
, lib
, ...
}:

{
  options.mine.rtorrent.enable = lib.mkEnableOption "rtorrent";

  config = lib.mkIf config.mine.rtorrent.enable {
    home-manager.users.${config.mine.user.name}.programs.rtorrent.enable = true;
  };
}
