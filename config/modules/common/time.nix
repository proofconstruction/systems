{ config
, ...
}:

{
  time.timeZone = config.private.users.alex.timeZone;
}
