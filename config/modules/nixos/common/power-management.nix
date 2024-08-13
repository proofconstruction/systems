{ config
, ...
}:
{
  config.services.upower.enable = true;
  config.systemd.services.upower.enable = true;
}
