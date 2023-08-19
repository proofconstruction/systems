{ config
, lib
, ...
}:

{
  options.mine.obs-studio.enable = lib.mkEnableOption "obs-studio";

  config = lib.mkIf config.mine.obs-studio.enable {
    home-manager.users.${config.mine.user.name}.programs.obs-studio.enable = true;
  };
}
