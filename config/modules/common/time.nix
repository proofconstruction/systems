{ config
, ...
}:

{
  time.timeZone = config.private.personal.timeZone;
}
