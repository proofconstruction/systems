{ config
, pkgs
, lib
, ...
}:

{
  options.custom.bluetooth.enable = lib.mkEnableOption "bluetooth";

  config = lib.mkIf config.custom.bluetooth.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
