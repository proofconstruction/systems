{ config
, pkgs
, lib
, ...
}:

{
  options.custom.zathura.enable = lib.mkEnableOption "zathura";

  config = lib.mkIf config.custom.zathura.enable {
    home-manager.users.${config.custom.user.name}.programs.zathura.enable = true;
  };
}
