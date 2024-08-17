{ config
, ...
}:

{
  home-manager.users.${config.custom.user.name}.programs = {
    nix-index = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
