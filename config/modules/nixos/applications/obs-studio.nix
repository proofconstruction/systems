{ config
, lib
, ...
}:

{
  options.custom.obs-studio.enable = lib.mkEnableOption "obs-studio";

  config = lib.mkIf config.custom.obs-studio.enable {
    home-manager.users.${config.custom.user.name}.programs.obs-studio.enable = true;
  };
}
