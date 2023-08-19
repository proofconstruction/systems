{ config
, ...
}:

{
  home-manager.users.${config.mine.user.name}.programs = {
    nix-index = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
