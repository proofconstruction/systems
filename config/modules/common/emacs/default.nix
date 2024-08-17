{ config
, lib
, pkgs
, ...
}:

{
  options.custom.emacs = with lib; {
    enable = mkEnableOption "emacs";
    package = mkOption {
      type = types.package;
      example = pkgs.emacs-nox;
      description = "Which Emacs to enable.";
    };
    configText = mkOption {
      type = types.str;
      description = ".emacs source";
    };
    configExtra = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Additional configuration to append to .emacs";
    };
  };

  config = lib.mkIf config.custom.emacs.enable {
    environment.pathsToLink = [ "/share/emacs" ];
    services.emacs = {
      enable = true;
      package = config.custom.emacs.package;
      defaultEditor = true;
      install = true;
    };

    home-manager.users.${config.custom.user.name} = {
      programs.emacs = {
        enable = true;
        package = config.custom.emacs.package;
      };

      home.file.".emacs".text = lib.concatLines (
        [ config.custom.emacs.configText ]
        ++ config.custom.emacs.configExtra
      );
    };
  };
}
