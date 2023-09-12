{ config
, pkgs
, lib
, ...
}:

{
  options.mine.exa.enable = lib.mkEnableOption "exa";

  config = lib.mkIf config.mine.exa.enable {
    home-manager.users.${config.mine.user.name}.programs.exa = {
      enable = true;
      enableAliases = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
      git = true;
      icons = true;
    };
  };
}
