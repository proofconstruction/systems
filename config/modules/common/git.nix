{ config
, pkgs
, ...
}:

let
  cfgp = config.private.users.alex;
in
{
  config.home-manager.users.${cfgp.username}.programs = {
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = cfgp.username;
      userEmail = cfgp.gitEmail;
    };
  };
}
