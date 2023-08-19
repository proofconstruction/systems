{ config
, pkgs
, lib
, ...
}:

{
  options.mine.bluetooth.enable = lib.mkEnableOption "bluetooth";

  config = lib.mkIf config.mine.bluetooth.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
