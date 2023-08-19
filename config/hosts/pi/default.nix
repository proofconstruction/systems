{ config
, pkgs
, lib
, ...
}:

{
  config = {
    powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

    environment.systemPackages = with pkgs; [
      raspberrypifw
      raspberrypi-eeprom
      libraspberrypi
    ];

    # enable GPU acceleration
    hardware.raspberry-pi."4".fkms-3d.enable = true;

    roles = {
      server = true;
      git-server = true;
    };

    mine.nix.caches.nix-community.enable = true;
  };

  imports = [
    ./boot.nix
    ./filesystems.nix
    ./networking.nix
  ];
}
