{ config
, pkgs
, lib
, ...
}:
{
  options.mine.kvm.enable = lib.mkEnableOption "the kernel virtual machine";

  config = lib.mkIf config.mine.kvm.enable {
    virtualisation.libvirtd.enable = true;
    users.extraUsers.${config.mine.user.name}.extraGroups = [ "libvirtd" ];

    boot.extraModprobeConfig = ''
      options kvm_intel nested=1
      options kvm_intel emulate_invalid_guest_state=0
      options kvm ignore_msrs=1
    '';
  };
}
