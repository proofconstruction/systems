{ config
, pkgs
, lib
, ...
}:

{
  options.custom.podman.enable = lib.mkEnableOption "podman";

  config = lib.mkMerge [
    (lib.mkIf config.custom.podman.enable {
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
      };
    })

    (lib.mkIf config.custom.nvidia.enable {
      hardware.nvidia-container-toolkit.enable = true;
    })
  ];
}
