{ config
, lib
, pkgs
, ...
}:
let
  theme = "clean";
in
{
  config = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      syntaxHighlighting.enable = true;
      shellInit = ''
        [[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return
      '';
      ohMyZsh = {
        enable = true;
        theme = theme;
      };
    };
    environment.pathsToLink = [ "/share/zsh" ];

    home-manager.users.${config.custom.user.name}.programs = {
      zsh = {
        enable = true;
        autosuggestion.enable = true;
        enableCompletion = true;
        autocd = true;
        defaultKeymap = "emacs";
        dotDir = ".config/zsh";
        history = {
          extended = true;
          share = true;
        };
        oh-my-zsh = {
          enable = true;
          plugins = [ "pass" "sudo" ];
          theme = theme;
        };
        initExtra = ''
          # fix emacs tramp hanging when the remote host has zsh
          [[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return
        '';
      };
    };
  };
}
