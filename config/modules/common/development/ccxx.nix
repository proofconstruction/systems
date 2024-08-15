{ config
, pkgs
, lib
, ...
}:
{
  options.mine.development.ccxx.enable = lib.mkEnableOption "C/C++ devtools";

  config = lib.mkIf config.mine.development.ccxx.enable {
    home-manager.users.${config.mine.user.name}.home.packages = with pkgs; [
      clangd
    ];
  };
}
