{ config, lib, pkgs, ... }:

{
  # Kernel version
  boot.kernelPackages = pkgs.linuxPackages;

  # Use unfree Intel drivers
  hardware.enableRedistributableFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  # CPU throttling
  services.throttled.enable = true;

  # Default kernel modules
  boot.initrd.availableKernelModules = [
    "xhci_pci" "nvme" "usb_storage" "sd_mod" "acpi_call"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.blacklistedKernelModules = [ "i915" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.acpi_call ];

  # Enable basic NVIDIA support (needs testing)
  # https://github.com/NixOS/nixpkgs/issues/53269#issuecomment-454726649
  services.xserver.videoDrivers = [ "intel" ];

  # NVIDIA Optimus
  environment.systemPackages = with config.boot.kernelPackages.nvidia_x11; [ bin settings ];
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.prime = {
    enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  hardware.nvidiaOptimus.disable = false;

  # NVIDIA Bumblebee
  hardware.bumblebee = {
    enable = true;
    driver = "nvidia";
  };

  # OpenGL with NVIDIA in mind
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs; [
    # NOTE: Are these even needed?
    libGL_driver
    config.boot.kernelPackages.nvidia_x11.out
    # Intel support
    vaapiIntel
    vaapiVdpau
    libvdpau-va-gl
  ];

  # Use the systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Filesystem (configured by nixos-install)
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/a08f78e7-bc3b-4f1c-8332-d4c098f9cb78";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/D9F0-DD1D";
      fsType = "vfat";
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/f2c44b27-e6d3-46ea-9db6-b581f184120b"; }
  ];

  # Other defaults
  nix.maxJobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
