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
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "acpi_call" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.blacklistedKernelModules = [ "i915" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.acpi_call ];

  # Udev support for Moonlander keyboard
  hardware.keyboard.zsa.enable = true;
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", \
      TAG+="systemd", ENV{SYSTEMD_USER_WANTS}="keyboard.service"
  '';

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

  swapDevices =
    [{ device = "/dev/disk/by-uuid/f2c44b27-e6d3-46ea-9db6-b581f184120b"; }];

  # Other defaults
  nix.settings.max-jobs = lib.mkDefault 8;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
