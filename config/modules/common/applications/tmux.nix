{ config
, lib
, pkgs
, ...
}:

let
  defaultShell = "${config.custom.user.shell.out}";
  defaultCommand = lib.lists.last (lib.strings.splitString "/" defaultShell);
  setDefaultShell = "set -g default-shell ${defaultShell}";
  setDefaultCommand = "set -g default-command ${defaultCommand}";
in
{
  options.custom.tmux.enable = lib.mkEnableOption "tmux";

  config = lib.mkIf config.custom.tmux.enable {
    home-manager.users.${config.custom.user.name}.programs = {
      tmux = {
        enable = true;
        clock24 = true;
        disableConfirmationPrompt = true;
        historyLimit = 1000;
        newSession = true;
        terminal = "screen-256color";
        baseIndex = 1;
        escapeTime = 0;
        extraConfig =
          lib.concatLines [
            setDefaultShell
            setDefaultCommand
            ''
              set -g status on
              set -g mouse on

              bind-key S-left swap-window -t -1
              bind-key S-right swap-window -t +1

              bind h select-pane -L
              bind k select-pane -D
              bind j select-pane -U
              bind l select-pane -R

              set-window-option -g automatic-rename
            ''
          ];

        plugins = with pkgs; [
          tmuxPlugins.nord
          tmuxPlugins.copycat
          tmuxPlugins.yank
          tmuxPlugins.sidebar
          tmuxPlugins.sensible
          tmuxPlugins.sessionist
          tmuxPlugins.resurrect
          {
            plugin = tmuxPlugins.continuum;
            extraConfig = ''
              # tmux-continuum settings
              set -g @continuum-restore 'on'
              set -g @continuum-save-interval '30' #save every half hour
            '';
          }
        ];
      };
    };
  };
}
