{ config
, lib
, ...
}:

{
  options.mine.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf config.mine.direnv.enable {
    home-manager.users.${config.mine.user.name}.programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };
    };
  };
}
