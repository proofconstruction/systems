{ config
, pkgs
, lib
, ...
}:

{
  options.roles.ai-host = lib.mkEnableOption "ML models";

  config = lib.mkIf config.roles.ai-host {
    custom.ollama.enable = true;
  };
}
