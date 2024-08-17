{ config
, lib
, ...
}:

{
  options.custom.flameshot.enable = lib.mkEnableOption "screenshots with flameshot";

  config = lib.mkIf config.custom.flameshot.enable {
    home-manager.users.${config.custom.user.name}.services.flameshot.enable = true;
  };
}
