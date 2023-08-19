{ config
, pkgs
, ...
}:

{
  config = {
    networking = {
      networkmanager.enable = true;
      useDHCP = false;
      interfaces = {
        wifi = {
          name = "wlp2s0";
          useDHCP = true;
        };
        ethernet = {
          name = "enp0s31f6";
          useDHCP = true;
        };
      };
    };
  };
}
