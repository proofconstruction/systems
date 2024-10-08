{ config
, lib
, ...
}:
{
  options.roles.git-server = lib.mkEnableOption "the git daemon";

  config = lib.mkIf config.roles.git-server {
    custom = {
      gitDaemon.enable = true;
      forgejo.enable = true;
      # make sure we can fetch SSL certs
      acme.enable = true;

    };
  };
}
