{ config
, lib
, ...
}:

{
  options.mine.fzf.enable = lib.mkEnableOption "fzf";

  config = lib.mkIf config.mine.fzf.enable {
    home-manager.users.${config.mine.user.name}.programs = {
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
