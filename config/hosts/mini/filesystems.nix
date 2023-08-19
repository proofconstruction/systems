{ config
, pkgs
, ...
}:

{
  config = {
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/2a8a811d-1144-47c2-a602-e6205aed0551";
        fsType = "ext4";
      };

      "/boot" = {
        device = "/dev/disk/by-uuid/4D2A-F74E";
        fsType = "vfat";
      };
    };
  };
}
