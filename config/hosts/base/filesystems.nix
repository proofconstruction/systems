{ config
, ...
}:

{
  config = {
    fileSystems = {
      "/" =
        {
          device = "/dev/disk/by-uuid/0795136e-a591-4094-97e5-3e0f9b6eaf6f";
          fsType = "ext4";
        };

      "/boot" =
        {
          device = "/dev/disk/by-uuid/B47C-E6B0";
          fsType = "vfat";
        };
    };
  };
}
