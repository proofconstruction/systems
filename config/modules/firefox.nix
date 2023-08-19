{ config
, lib
, ...
}:

{
  options.mine.firefox.enable = lib.mkEnableOption "firefox";

  config = lib.mkIf config.mine.firefox.enable {
    home-manager.users.${config.mine.user.name}.programs.firefox.enable = true;
  };
}
