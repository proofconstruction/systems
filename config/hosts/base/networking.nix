{ config
, ...
}:

{
  config = {
    networking = {
      useDHCP = false;
      interfaces = {
        ethernet = {
          name = "enp4s0";
          useDHCP = true;
          wakeOnLan.enable = true;
        };
      };
    };
  };
}
