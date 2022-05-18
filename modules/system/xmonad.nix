{ config, pkgs, lib, ... }:

{
  services.xserver = {
    enable = true;

    layout = "us";

    displayManager.autoLogin = {
      enable = true;
      user = "alex";
    };

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };
}
