{ config
, pkgs
, ...
}:

{
  config = {
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/8d1ceddc-c16f-4adb-a71e-41497b9b037e";
        fsType = "ext4";
      };

      "/boot" = {
        device = "/dev/disk/by-uuid/E0F1-4543";
        fsType = "vfat";
      };
    };
  };
}
