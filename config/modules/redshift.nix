{ config
, lib
, ...
}:
{
  options.mine.redshift.enable = lib.mkEnableOption "redshift";

  config = lib.mkIf config.mine.redshift.enable {

    services.geoclue2.enable = true;

    home-manager.users.${config.mine.user.name}.services.redshift = {
      enable = true;
      provider = "geoclue2";
      settings.redshift = {
        brightness-day = "1";
        brightness-night = "1";
      };
      temperature = {
        day = 5500;
        night = 3700;
      };
    };
  };
}
