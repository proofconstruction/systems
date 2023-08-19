{ config
, ...
}:
{
  config = {
    services.openssh.enable = true;
    programs.ssh.startAgent = true;

    home-manager.users.${config.mine.user.name}.programs.ssh = {
      enable = true;
    };
  };
}
