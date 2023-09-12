{ config
, lib
, ...
}:

{
  options.mine.htop.enable = lib.mkEnableOption "htop";

  config = lib.mkIf config.mine.htop.enable {
    home-manager.users.${config.mine.user.name}.programs = {
      htop = {
        enable = true;
        settings.color_scheme = 5;
      };
    };
  };
}
