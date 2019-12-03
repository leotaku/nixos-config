{ config, pkgs, ... }:

{
  services.xserver = {
    layout = "de";
    xkbVariant = "leo";
  };

  nixpkgs.config = {
    packageOverrides = super: rec {

      xorg = super.xorg // rec {
        xkeyboardconfig-custom = super.xorg.xkeyboardconfig.overrideAttrs
          (oldAttrs: { patches = [ ./test.patch ]; });

        xorgserver = super.xorg.xorgserver.overrideAttrs (oldAttrs: {
          configureFlags = oldAttrs.configureFlags ++ [
            "--with-xkb-bin-directory=${xkbcomp}/bin"
            "--with-xkb-path=${xkeyboardconfig-custom}/share/X11/xkb"
          ];
        });

        setxkbmap = super.xorg.setxkbmap.overrideAttrs (oldAttrs: {
          postInstall = ''
            mkdir -p $out/share
            ln -sfn ${xkeyboardconfig-custom}/etc/X11 $out/share/X11
          '';
        });

        xkbcomp = super.xorg.xkbcomp.overrideAttrs (oldAttrs: {
          configureFlags =
            "--with-xkb-config-root=${xkeyboardconfig-custom}/share/X11/xkb";
        });

      };

      xkbvalidate = super.xkbvalidate.override {
        libxkbcommon = super.libxkbcommon.override {
          xkeyboard_config = xorg.xkeyboardconfig-custom;
        };
      };
    };
  };
}
