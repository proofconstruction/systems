{ config
, pkgs
, lib
, ...
}:

{
  options.mine.gnome.enable = lib.mkEnableOption "gnome";

  config = lib.mkIf config.mine.gnome.enable {
    services = {
      xserver = {
        enable = true;
        xkb.layout = "us";

        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
    };
  };
}
