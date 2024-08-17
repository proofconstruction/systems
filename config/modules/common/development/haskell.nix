{ config
, pkgs
, lib
, ...
}:
{
  options.custom.development.haskell.enable = lib.mkEnableOption "Haskell devtools";

  config = lib.mkIf config.custom.development.haskell.enable {
    home-manager.users.${config.custom.user.name}.home.packages = with pkgs; [
      ghc
    ];
  };
}
