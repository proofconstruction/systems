{ config
, pkgs
, lib
, ...
}:
{
  options.mine.development.rust.enable = lib.mkEnableOption "rust devtools";

  config = lib.mkIf config.mine.development.rust.enable {
    home-manager.users.${config.mine.user.name}.home.packages = with pkgs; [
      cargo
      rustc
      rust-analyzer
    ];
  };
}
