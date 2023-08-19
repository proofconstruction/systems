{ config
, pkgs
, ...
}:

{
  config = {
    services.xserver = {
      videoDrivers = [ "intel" ];
      dpi = 210;
      xkbOptions = "ctrl:nocaps";

      libinput = {
        enable = true;
        touchpad = {
          naturalScrolling = true;
          accelSpeed = "0.1";
        };
      };
    };
  };
}
