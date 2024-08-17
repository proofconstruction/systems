{ config
, lib
, ...
}:

{
  options.roles.vm-host = lib.mkEnableOption "KVM and other virtualization systems";

  config = lib.mkIf config.roles.vm-host {
    custom = {
      kvm.enable = true;
      podman.enable = true;
    };
  };
}
