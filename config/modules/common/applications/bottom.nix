{ config
, lib
, ...
}:

{
  options.custom.bottom.enable = lib.mkEnableOption "btm";

  config = lib.mkIf config.custom.bottom.enable {
    home-manager.users.${config.custom.user.name}.programs = {
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
