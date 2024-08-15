{ config
, ...
}:

{
  config = {
    security.pam.enableSudoTouchIdAuth = true;
  };
}
