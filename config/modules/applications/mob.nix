{ config
, pkgs
, lib
, ...
}:
{
  options.mine.mob.enable = lib.mkEnableOption "mob";

  config = lib.mkIf config.mine.mob.enable {
    home-manager.users.${config.mine.user.name}.home.packages = with pkgs; [
      mob
    ];
  };
}
