{ config
, pkgs
, lib
, ...
}:

{
  options.custom.printing.enable = lib.mkEnableOption "printers";

  config = lib.mkIf config.custom.printing.enable {
    services = {
      printing.enable = true;
      avahi.enable = true;
      avahi.nssmdns = true;
      # for a WiFi printer
      avahi.openFirewall = true;
    };
  };
}
