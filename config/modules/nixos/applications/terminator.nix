{ config
, lib
, pkgs
, ...
}:

{
  options.mine.terminator.enable = lib.mkEnableOption "terminator";

  config = lib.mkIf config.mine.terminator.enable {
    home-manager.users.${config.mine.user.name}.programs = {
      terminator = {
        enable = true;
        config = {
          global_config.borderless = true;

          profiles = {
            default = {
              font = "Fira Mono 16";
              scrollback_lines = 10000;
              show_titlebar = false;
              toggle_scrollbar = false;
              audible_bell = false;
              visible_bell = true;

              use_theme_colors = false;
              background_color = "#2e3440";
              foreground_color = "#eceff4";
            };
          };
        };
      };
    };
  };
}
