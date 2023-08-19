{ config
, ...
}:

{
  config.home-manager.users.${config.mine.user.name}.programs.home-manager.enable = true;
}
