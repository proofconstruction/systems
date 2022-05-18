{ config, pkgs, lib, ... }:

{
  environment = {
    pathsToLink = [
      "/share/zsh"
      "/share/emacs"
    ];
  };
}
