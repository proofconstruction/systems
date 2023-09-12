{ config
, lib
, ...
}:

{
  config.mine = {
    bottom.enable = true;
    eza.enable = true;
    fzf.enable = true;
    ripgrep.enable = true;
    tmux.enable = true;
  };
}
