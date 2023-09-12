{ config
, lib
, ...
}:

{
  options = {
    mine.cpuMicrocode = {
      enable = lib.mkEnableOption "CPU microcode updates";
      manufacturer = lib.mkOption { type = lib.types.enum [ "amd" "intel" ]; };
    };
  };

  config = lib.mkIf config.mine.cpuMicrocode.enable {
    hardware.cpu.amd.updateMicrocode = (config.mine.cpuMicrocode.manufacturer == "amd");
    hardware.cpu.intel.updateMicrocode = (config.mine.cpuMicrocode.manufacturer == "intel");
  };
}
