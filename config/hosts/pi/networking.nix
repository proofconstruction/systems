{ config
, pkgs
, ...
}:

{
  config = {
    networking = {
      useDHCP = false;
      firewall.enable = false;
      interfaces = {
        ethernet = {
          name = "end0";
          useDHCP = true;
        };
      };
    };
  };
}
