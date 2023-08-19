{ config, lib, pkgs, ... }:

{
  console = {

    # larger terminus font for the console
    font = "ter-i32b";
    packages = with pkgs; [ terminus_font ];

    # set vconsole options in initrd
    earlySetup = true;
  };
}
