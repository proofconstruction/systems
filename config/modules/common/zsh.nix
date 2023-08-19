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

    home-manager.users.${config.mine.user.name}.programs = {
      zsh = {
        enable = true;
        enableAutosuggestions = true;
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
      };
    };
  };
}
