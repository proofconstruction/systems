{ config
, pkgs
, lib
, ...
}:
let
  cfg = config.mine.user;
in
{
  options.mine.password-store.enable = lib.mkEnableOption "pass";

  config = lib.mkIf config.mine.password-store.enable {
    home-manager.users.${cfg.name}.programs = {
      password-store = {
        enable = true;
        package = pkgs.pass.withExtensions (exts: with exts; [ pass-otp pass-update pass-audit ]);
        settings = {
          PASSWORD_STORE_DIR = "/home/${cfg.name}/.password-store";
          PASSWORD_STORE_CLIP_TIME = "60";
        };
      };
    };
  };
}
