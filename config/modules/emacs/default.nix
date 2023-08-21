{ config
, lib
, pkgs
, ...
}:

{
  options.mine.emacs = with lib; {
    enable = mkEnableOption "emacs";
    package = mkOption {
      type = types.package;
      default = myEmacs;
      example = pkgs.emacs-nox;
      description = "Which Emacs to enable.";
    };
    configText = mkOption {
      type = types.str;
      default = emacsConfig;
      description = ".emacs source";
    };
    configExtra = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Additional configuration to append to .emacs";
    };
  };

  config = lib.mkIf config.mine.emacs.enable {
    environment.pathsToLink = [ "/share/emacs" ];
    services.emacs = {
      enable = true;
      package = config.mine.emacs.package;
      defaultEditor = true;
      install = true;
    };

    home-manager.users.${config.mine.user.name} = {
      programs.emacs = {
        enable = true;
        package = config.mine.emacs.package;
      };

      home.file.".emacs".text = lib.concatLines ([
        config.mine.emacs.configText
      ] ++ config.mine.emacs.configExtra);
    };
  };
}
