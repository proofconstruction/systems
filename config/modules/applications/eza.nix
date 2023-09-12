{ config
, pkgs
, lib
, ...
}:

{
  options.mine.eza.enable = lib.mkEnableOption "eza";

  config = lib.mkIf config.mine.eza.enable {
    home-manager.users.${config.mine.user.name}.programs.eza = {
      enable = true;
      enableAliases = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
      git = true;
    };
  };
}
