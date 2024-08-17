{ config
, lib
, pkgs
, ...
}:

{
  options.custom.unclutter.enable = with lib; mkOption {
    type = types.bool;
    default = false;
    description = "Whether to enable auto-hiding the mouse cursor.";
  };

  config = lib.mkIf config.custom.unclutter.enable {
    home-manager.users.${config.custom.user.name}.services.unclutter.enable = true;
  };
}
