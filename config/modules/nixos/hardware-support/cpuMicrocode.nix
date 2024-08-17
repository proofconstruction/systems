{ config
, lib
, ...
}:

{
  options = {
    custom.cpuMicrocode = {
      enable = lib.mkEnableOption "CPU microcode updates";
      manufacturer = lib.mkOption { type = lib.types.enum [ "amd" "intel" ]; };
    };
  };

  config = lib.mkIf config.custom.cpuMicrocode.enable {
    hardware.cpu.amd.updateMicrocode = (config.custom.cpuMicrocode.manufacturer == "amd");
    hardware.cpu.intel.updateMicrocode = (config.custom.cpuMicrocode.manufacturer == "intel");
  };
}
