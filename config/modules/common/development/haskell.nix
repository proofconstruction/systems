{ config
, pkgs
, lib
, ...
}:
{
  options.mine.development.haskell.enable = lib.mkEnableOption "Haskell devtools";

  config = lib.mkIf config.mine.development.haskell.enable {
    home-manager.users.${config.mine.user.name}.home.packages = with pkgs; [
      ghc
    ];
  };
}
