{ config
, pkgs
, lib
, ...
}:
{
  options.custom.development.ccxx.enable = lib.mkEnableOption "C/C++ devtools";

  config = lib.mkIf config.custom.development.ccxx.enable {
    home-manager.users.${config.custom.user.name}.home.packages = with pkgs; [
      clangd
    ];
  };
}
