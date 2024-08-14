{ config
, ...
}:

{
  config = {
    networking = {
      domain = config.private.homelab.domain;
      useDHCP = false;
      interfaces = {
        ethernet = {
          name = "enp5s0";
          useDHCP = true;
          wakeOnLan.enable = true;
        };
      };
      networkmanager.enable = true;
    };
  };
}
