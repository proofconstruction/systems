{ config
, pkgs
, ...
}:

{
  config = {
    networking = {
      # using nftables instead
      firewall.enable = false;
      useDHCP = false;
      interfaces = {
        wan = {
          name = "enp1s0f0";
          useDHCP = true;
        };
        lan = {
          name = "enp0s20u1";
          useDHCP = false;
        };
      };
    };
  };
}
