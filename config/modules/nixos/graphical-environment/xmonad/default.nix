{ config
, pkgs
, lib
, ...
}:

{
  options.mine.xmonad.enable = lib.mkEnableOption "xmonad";

  config = lib.mkIf config.mine.xmonad.enable {
    services = {
      xserver = {
        enable = true;
        xkb.layout = "us";

        windowManager.xmonad = {
          enable = true;
          enableContribAndExtras = true;
        };
      };
      displayManager.autoLogin = {
        enable = true;
        user = config.mine.user.name;
      };
    };

    home-manager.users.${config.mine.user.name}.home = {
      file.".xmonad/xmonad.hs".source = ./xmonad.hs;
      file.".xmobarrc".source = ./xmobarrc;
      packages = with pkgs; [
        xmobar
        arandr
        gtk3
      ];
    };
  };
}
