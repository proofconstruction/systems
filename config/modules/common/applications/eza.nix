{ config
, pkgs
, lib
, ...
}:

{
  options.custom.eza.enable = lib.mkEnableOption "eza";

  config = lib.mkIf config.custom.eza.enable {
    home-manager.users.${config.custom.user.name}.programs.eza = {
      enable = true;
      enableBashIntegration = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
      git = true;
    };
  };
}
