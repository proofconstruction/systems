{ config
, pkgs
, lib
, ...
}:
{
  options.custom.development.rust.enable = lib.mkEnableOption "rust devtools";

  config = lib.mkIf config.custom.development.rust.enable {
    home-manager.users.${config.custom.user.name}.home.packages = with pkgs; [
      cargo
      rustc
      rust-analyzer
    ];
  };
}
