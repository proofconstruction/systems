{ config
, lib
, ...
}:
{
  options.roles.binary-cache = lib.mkEnableOption "a nix binary cache";

  config = lib.mkIf config.roles.binary-cache {
    custom.nix-serve.enable = true;
  };
}
