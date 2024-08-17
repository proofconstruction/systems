{ config
, lib
, ...
}:

{
  options.roles.server = lib.mkEnableOption "stuff specific to my servers.";

  config = lib.mkIf config.roles.server {
    custom = {
      gnupg.enable = true;
      podman.enable = true;
    };
  };
}
