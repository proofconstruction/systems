{ config
, pkgs
, lib
, ...
}:

{
  options.mine.podman.enable = lib.mkEnableOption "podman";

  config = lib.mkMerge [
    (lib.mkIf config.mine.podman.enable {
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
      };
    })

    (lib.mkIf config.mine.nvidia.enable {
      virtualisation.podman.enableNvidia = true;
    })
  ];
}
