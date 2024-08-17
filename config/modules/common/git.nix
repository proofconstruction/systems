{ config
, lib
, pkgs
, ...
}:

{
  config.home-manager.users.${config.custom.user.name}.programs = {
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = config.private.personal.fullName;
      userEmail = config.private.personal.gitEmail;
    };
  };
}
