{ config
, lib
, ...
}:

{
  options.custom.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf config.custom.direnv.enable {
    home-manager.users.${config.custom.user.name}.programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
    };
  };
}
