{ config
, lib
, ...
}:

{
  options.custom.redistributableFirmware.enable = lib.mkEnableOption "closed firmware blobs";

  config = lib.mkIf config.custom.redistributableFirmware.enable {
    hardware.enableRedistributableFirmware = true;
  };
}
