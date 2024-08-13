{ config
, lib
, pkgs
, ...
}:
let
  modi = "run,drun,ssh,filebrowser,power-menu:${pkgs.rofi-power-menu}";
  terminal = "${pkgs.kitty}/bin/kitty";

  plugins = with pkgs; [
    rofi-emoji
    rofi-bluetooth
    rofi-power-menu
    rofi-calc
    pinentry-rofi
  ];
in
{
  options.mine.rofi.enable = lib.mkEnableOption "rofi";

  config = lib.mkIf config.mine.rofi.enable {
    mine.pinentry.enable = true;
    home-manager.users.${config.mine.user.name}.programs = {
      rofi = {
        enable = true;
        cycle = true;
        font = "xft:Roboto:antialias=true 16";
        inherit terminal;
        inherit plugins;
        location = "center";
        pass.enable = true;
        theme = "paper-float";
        extraConfig = {
          inherit terminal;
          inherit modi;
          disable-history = false;
          show-icons = true;
          sidebar-mode = false;
          sort = true;

          drun-display-format = "{icon} {name}";

          display-drun = "   Run ";
          display-emoji = "   Emoji ";
          display-window = " 﩯 Window ";
          display-power-menu = "  Power Menu ";
        };
      };
    };
  };
}
