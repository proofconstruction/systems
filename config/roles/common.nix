{ config
, lib
, ...
}:

{
  config.mine = {
    bottom.enable = true;
    exa.enable = true;
    fzf.enable = true;
    ripgrep.enable = true;
    tmux.enable = true;
  };
}
