{ config
, lib
, pkgs
, ...
}:

{
  config = {
    mine = {
      cpuMicrocode = {
        enable = true;
        manufacturer = "intel";
      };

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
