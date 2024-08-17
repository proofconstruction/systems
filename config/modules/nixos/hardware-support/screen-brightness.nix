{ config
, lib
, pkgs
, ...
}:

{
  options.custom.screen-brightness.enable = lib.mkEnableOption "screen-brightness";

  config = lib.mkIf config.custom.screen-brightness.enable {
    programs.light.enable = true;

    services.actkbd = {
      enable = true;
      bindings = [
        { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 5"; } # Light -
        { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 5"; } # Light +
      ];
    };
  };
}
