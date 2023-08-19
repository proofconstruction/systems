{ config
, lib
, pkgs
, ...
}: {
  config = {
    documentation = {
      enable = true;
      man.enable = true;
      info.enable = true;
    };
  };
}
