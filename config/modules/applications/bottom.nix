{ config
, lib
, ...
}:

{
  options.mine.bottom.enable = lib.mkEnableOption "btm";

  config = lib.mkIf config.mine.bottom.enable {
    home-manager.users.${config.mine.user.name}.programs = {
      bottom = {
        enable = true;
        settings = {
          flags = {
            avg_cpu = true;
            color = "default-light";
            temperature_type = "c";
          };
        };
      };
    };
  };
}
