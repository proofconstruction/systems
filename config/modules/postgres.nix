{ config
, pkgs
, lib
, ...
}:
{
  options.mine.postgres.enable = lib.mkEnableOption "postgres";

  config = lib.mkIf config.mine.postgres.enable {
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
