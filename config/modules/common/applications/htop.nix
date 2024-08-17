{ config
, lib
, ...
}:

{
  options.custom.htop.enable = lib.mkEnableOption "htop";

  config = lib.mkIf config.custom.htop.enable {
    home-manager.users.${config.custom.user.name}.programs = {
      htop = {
        enable = true;
        settings.color_scheme = 5;
      };
    };
  };
}
