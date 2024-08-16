{ config
, lib
, ...
}:

{
  options.roles.download-server = lib.mkEnableOption "Download server";

  config = lib.mkIf config.roles.download-server {
    custom.arr-stack.enable = true;
    custom.transmission.enable = true;
  };
}
