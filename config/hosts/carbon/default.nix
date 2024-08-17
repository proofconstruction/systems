{ config
, pkgs
, lib
, ...
}:

{
  config = {
    powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

    custom = {
      nix.caches.nix-community.enable = true;
      cpuMicrocode = {
        enable = true;
        manufacturer = "intel";
      };
      xmonad.enable = true;
    };

    roles = {
      workstation.nixos = true;
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
