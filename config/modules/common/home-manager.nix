{ config
, ...
}:

{
  config.home-manager.users.${config.custom.user.name}.programs.home-manager.enable = true;
}
