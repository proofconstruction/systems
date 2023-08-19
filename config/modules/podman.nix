{ config
, pkgs
, lib
, ...
}:

{
  options.mine.podman.enable = lib.mkEnableOption "podman";

  config = lib.mkIf config.mine.podman.enable {
    virtualisation.podman.enable = true;
  };
}
