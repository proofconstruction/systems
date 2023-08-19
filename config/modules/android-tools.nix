{ config
, pkgs
, lib
, ...
}:
{
  options.mine.android-tools.enable = lib.mkEnableOption "adb";

  config = lib.mkIf config.mine.android-tools.enable {
    home-manager.users.${config.mine.user.name}.home.packages = with pkgs; [
      android-tools
    ];
  };
}
