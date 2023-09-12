{ config
, pkgs
, lib
, ...
}:

{
  options.mine.zathura.enable = lib.mkEnableOption "zathura";

  config = lib.mkIf config.mine.zathura.enable {
    home-manager.users.${config.mine.user.name}.programs.zathura.enable = true;
  };
}
