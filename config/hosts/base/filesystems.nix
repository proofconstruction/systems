{ config
, ...
}:

{
  config = {
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/1d925250-0f93-4e26-b8d2-90a7b12c6b64";
        fsType = "ext4";
      };

      "/boot" = {
        device = "/dev/disk/by-uuid/4E3A-462A";
        fsType = "vfat";
      };
    };
  };
}
