{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.custom.user;
in
{
  options.custom.password-store.enable = lib.mkEnableOption "pass";

  config = lib.mkIf config.custom.password-store.enable {
    home-manager.users.${cfg.name}.programs = {
      password-store = {
        enable = true;
        package = pkgs.pass.withExtensions (exts: with exts; [ pass-otp pass-update pass-audit ]);
        settings = {
          PASSWORD_STORE_DIR = if pkgs.stdenv.isLinux then "/home/${cfg.name}/.password-store" else "/Users/${cfg.name}/.password-store";
          PASSWORD_STORE_CLIP_TIME = "60";
        };
      };
    };
  };
}
