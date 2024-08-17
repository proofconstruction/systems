{ config
, pkgs
, lib
, ...
}:
{
  options.custom.postgres.enable = lib.mkEnableOption "postgres";

  config = lib.mkIf config.custom.postgres.enable {
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_15;
      ensureDatabases = [ "testing" ];
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        local all       all     trust
      '';
    };
  };
}
