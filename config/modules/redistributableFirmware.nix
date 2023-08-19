{ config
, lib
, ...
}:

{
  options.mine.redistributableFirmware.enable = lib.mkEnableOption "closed firmware blobs";

  config = lib.mkIf config.mine.redistributableFirmware.enable {
    hardware.enableRedistributableFirmware = true;
  };
}
