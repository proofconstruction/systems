{ config
, lib
, pkgs
, ...
}:

{
  options.mine.gnupg.enable = lib.mkEnableOption "gnupg";

  config = lib.mkIf config.mine.gnupg.enable {
    mine.pinentry.enable = true;
    programs.gnupg.agent.enable = true;
    home-manager.users.${config.mine.user.name}.services.gpg-agent.enable = true;
  };
}
