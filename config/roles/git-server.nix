{ config
, lib
, ...
}:
{
  options.roles.git-server = lib.mkEnableOption "the git daemon";

  config = lib.mkIf config.roles.git-server {
    mine = {
      gitDaemon.enable = true;
    };
  };
}
