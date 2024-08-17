{ config
, pkgs
, lib
, ...
}:

{
  options.custom.gnome.enable = lib.mkEnableOption "gnome";

  config = lib.mkIf config.custom.gnome.enable {
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
