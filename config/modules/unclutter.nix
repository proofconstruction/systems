{ config
, lib
, pkgs
, ...
}:

{
  options.mine.unclutter.enable = with lib; mkOption {
    type = types.bool;
    default = false;
    description = "Whether to enable auto-hiding the mouse cursor.";
  };

  config = lib.mkIf config.mine.unclutter.enable {
    home-manager.users.${config.mine.user.name}.services.unclutter.enable = true;
  };
}
