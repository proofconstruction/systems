{ config
, pkgs
, lib
, ...
}:

{
  options.custom.ripgrep.enable = lib.mkEnableOption "ripgrep";

  config = lib.mkIf config.custom.ripgrep.enable {
    home-manager.users.${config.custom.user.name}.programs.ripgrep = {
      enable = true;
      arguments = [
        "--max-columns-preview"
        "--colors=line:style:bold"
      ];
    };
  };
}
