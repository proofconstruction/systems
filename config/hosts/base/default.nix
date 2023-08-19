{ config
, lib
, ...
}:

{
  config = {
    mine = {
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
      workstation = true;
      database-host = true;
    };
  };

  imports = [
    ./boot.nix
    ./networking.nix
    ./filesystems.nix
  ];
}
