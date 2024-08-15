{ config
, ...
}:

{
  config = {
    mine = {
      cpuMicrocode = {
        enable = true;
        manufacturer = "intel";
      };

      redistributableFirmware = true;

      nix.caches.nix-community.enable = true;
    };

    roles.router = true;
  };

  imports = [
    ./boot.nix
    ./filesystems.nix
    ./networking.nix
  ];
}
