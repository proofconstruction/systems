{ config, pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;

    layout = "us";

    displayManager.autoLogin = {
      enable = true;
      user = "alex";
    };

    windowManager.exwm.enable = true;

    displayManager.sessionCommands = "${pkgs.xorg.xhost}/bin/xhost +SI:localuser:$USER";
  };
}
