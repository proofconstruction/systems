{ config
, lib
, pkgs
, ...
}:

{
  options.mine.screen-brightness.enable = lib.mkEnableOption "screen-brightness";

  config = lib.mkIf config.mine.screen-brightness.enable {
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
