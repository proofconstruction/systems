{ config
, pkgs
, lib
, ...
}:
{
  options.custom.mob.enable = lib.mkEnableOption "mob";

  config = lib.mkIf config.custom.mob.enable {
    home-manager.users.${config.custom.user.name}.home.packages = with pkgs; [
      mob
    ];
  };
}
