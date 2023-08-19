{ config
, lib
, pkgs
, ...
}: {
  config = {
    programs.tmux = {
      enable = true;
    };
  };
}
