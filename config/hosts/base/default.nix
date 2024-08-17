{ config
, lib
, ...
}:

{
  config = {
    custom = {
      nix.caches = {
        haskell.enable = true;
        cuda.enable = true;
        nix-community.enable = true;
      };

      cpuMicrocode = {
        enable = true;
        manufacturer = "amd";
      };

      nvidia.enable = true;
    };

    roles = {
      binary-cache = true;
      database-host = true;
      git-server = true;
      vm-host = true;
    };
  };

  imports = [
    ./boot.nix
    ./networking.nix
    ./filesystems.nix
  ];
}
