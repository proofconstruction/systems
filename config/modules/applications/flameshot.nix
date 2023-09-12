{ config
, lib
, ...
}:

{
  options.mine.flameshot.enable = lib.mkEnableOption "screenshots with flameshot";

  config = lib.mkIf config.mine.flameshot.enable {
    home-manager.users.${config.mine.user.name}.services.flameshot.enable = true;
  };
}
