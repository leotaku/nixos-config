{ config, lib, pkgs, ... }:

{
  # Kernel version
  boot.kernelPackages = pkgs.linuxPackages;

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  boot.initrd.availableKernelModules = [
    "ehci_pci" "ahci" "megaraid_sas" "isci" "usbhid" "usb_storage" "sd_mod" "sr_mod"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems = {
    raid6x300gb = {
      device = "/dev/disk/by-uuid/7ec6e6b1-d914-4208-88b6-18c0f3a92bf1";
      fsType = "ext4";
      mountPoint = "/";
    };
    raid1x5tb = {
      device = "/dev/disk/by-uuid/6bb69ac8-407f-4985-9922-3e85796e836e";
      fsType = "ext4";
      mountPoint = "/mnt/raid1x5tb";
    };
    raid0x1tb = {
      device = "/dev/disk/by-uuid/f4c1dcee-955b-48eb-a8a7-121ccd926df4";
      fsType = "ext4";
      mountPoint = "/mnt/raid0x1tb";
    };
  };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 12;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
}
