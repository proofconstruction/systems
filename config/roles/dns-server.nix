{ config
, lib
, ...
}:

{
  options.roles.dns-server = lib.mkEnableOption "DNS server";

  config = lib.mkIf config.roles.dns-server {
    custom.technitium-dns-server.enable = true;
  };
}
