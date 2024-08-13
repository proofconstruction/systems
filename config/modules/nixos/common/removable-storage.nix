{ config
, ...
}:
{
  config.services.devmon.enable = true;
  config.services.udisks2.enable = true;
}
