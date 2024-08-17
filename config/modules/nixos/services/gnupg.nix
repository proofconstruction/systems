{ config
, lib
, pkgs
, ...
}:

{
  options.custom.gnupg.enable = lib.mkEnableOption "gnupg";

  config = lib.mkIf config.custom.gnupg.enable {
    custom.pinentry.enable = true;
    programs.gnupg.agent.enable = true;
    home-manager.users.${config.custom.user.name}.services.gpg-agent.enable = true;
  };
}
