{ config
, lib
, ...
}:

{
  options.custom.firefox.enable = lib.mkEnableOption "firefox";

  config = lib.mkIf config.custom.firefox.enable {
    home-manager.users.${config.custom.user.name}.programs.firefox.enable = true;
  };
}
