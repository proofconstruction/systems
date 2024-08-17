{ config
, lib
, ...
}:

{
  options.custom.fzf.enable = lib.mkEnableOption "fzf";

  config = lib.mkIf config.custom.fzf.enable {
    home-manager.users.${config.custom.user.name}.programs = {
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
