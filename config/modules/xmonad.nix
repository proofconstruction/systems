{ config
, pkgs
, lib
, ...
}:

{
  options.mine.xmonad.enable = lib.mkEnableOption "xmonad";

  config = lib.mkIf config.mine.xmonad.enable {
    services.xserver = {
      enable = true;

      layout = "us";

      displayManager.autoLogin = {
        enable = true;
        user = config.mine.user.name;
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };

    home-manager.users.${config.mine.user.name}.home.packages = with pkgs; [
      xmobar
      arandr
      gtk3
    ];
  };
}
