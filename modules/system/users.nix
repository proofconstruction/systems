{ config, pkgs, lib, ...}:

{
  users.users = {
    alex = {
      isNormalUser = true;
      uid = 1000;
      createHome = true;
      name = "alex";
      group = "users";
      extraGroups = [
        "wheel" "disk" "audio" "video"
        "networkmanager" "systemd-journal"
      ];
      home = "/home/alex";
      shell = pkgs.zsh;
    };
  };
}
