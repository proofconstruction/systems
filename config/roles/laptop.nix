{ config
, lib
, ...
}:
{
  options.roles.laptop = lib.mkEnableOption "stuff specific to my X1 Carbon";

  config = lib.mkIf config.roles.laptop {
    mine = {
      screen-brightness.enable = true;
    };
  };
}
