{ config
, lib
, ...
}:
{
  options.roles.database-host = lib.mkEnableOption "databases";

  config = lib.mkIf config.roles.database-host {
    custom.postgres.enable = true;
  };
}
