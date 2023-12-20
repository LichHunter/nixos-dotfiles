{ config, lib, pkgs, ... }:

{
  imports = [
      ./cpu/amd
      ./cpu/amd/pstate.nix
      #./gpu/amd
      ./gpu/nvidia/prime.nix
      ./pc/laptop
      #./pc/ssd
  ];

  hardware.nvidia.prime = {
    amdgpuBusId = "PCI:6:0:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # Enables ACPI platform profiles
  boot = lib.mkIf (lib.versionAtLeast pkgs.linux.version "6.1") {
    kernelModules = [ "hp-wmi" ];
  };
}
