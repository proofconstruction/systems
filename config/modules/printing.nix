{ config
, pkgs
, lib
, ...
}:

{
  options.mine.printing.enable = lib.mkEnableOption "printers";

  config = lib.mkIf config.mine.printing.enable {
    services = {
      printing.enable = true;
      avahi.enable = true;
      avahi.nssmdns = true;
      # for a WiFi printer
      avahi.openFirewall = true;
    };
  };
}
