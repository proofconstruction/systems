{ config
, pkgs
, lib
, ...
}:

{
  options.mine.ripgrep.enable = lib.mkEnableOption "ripgrep";

  config = lib.mkIf config.mine.ripgrep.enable {
    home-manager.users.${config.mine.user.name}.programs.ripgrep = {
      enable = true;
      arguments = [
        "--max-columns-preview"
        "--colors=line:style:bold"
      ];
    };
  };
}
