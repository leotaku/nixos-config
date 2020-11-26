{ config, pkgs, lib, ... }: {
  # ZSA keyboard training
  services.udev.packages = let
    text = ''
      # Rule for all ZSA keyboards
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
      # Rule for the Moonlander
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
      # Rule for the Ergodox EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
      # Rule for the Planck EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"
    '';
    name = "50-oryx.rules";
    zsa = pkgs.writeTextFile {
      destination = "/etc/udev/rules.d/${name}";
      inherit name text;
    };
  in [ zsa ];

  # Add plugdev group
  users.groups.plugdev = { };
}
