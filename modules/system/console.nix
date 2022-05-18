{ config, lib, pkgs, ... }:

{
  console = {

    # set vconsole options in initrd
    earlySetup = true;
  };
}
