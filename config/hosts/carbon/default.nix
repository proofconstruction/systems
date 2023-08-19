{ config
, pkgs
, lib
, ...
}:

{
  config = {
    powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

    mine = {
      nix.caches.nix-community.enable = true;
      cpuMicrocode = {
        enable = true;
        manufacturer = "intel";
      };
    };

    roles = {
      workstation = true;
      laptop = true;
    };
  };

  imports = [
    ./boot.nix
    ./filesystems.nix
    ./networking.nix
    ./xserver.nix
  ];
}
