{ config
, lib
, pkgs
, ...
}:

{
  options.mine.kitty.enable = lib.mkEnableOption "kitty";

  config = lib.mkIf config.mine.kitty.enable {
    home-manager.users.${config.mine.user.name}.programs = {
      kitty = {
        enable = true;
        font = {
          name = "Fira Mono";
          package = pkgs.fira-mono;
          size = 12;
        };
        settings = {
          scrollback_lines = 10000;
          enable_audio_bell = false;
          update_check_interval = 0;
        };
        shellIntegration.enableZshIntegration = true;
        theme = "Tango Light";
      };
    };
  };
}
