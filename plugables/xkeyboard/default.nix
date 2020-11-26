self: super: rec {
  xorg = super.xorg // rec {
    xkb_patched = super.xorg.xkeyboardconfig.overrideAttrs
      (oldAttrs: { patches = [ ./custom.patch ]; });
    xorgserver = super.xorg.xorgserver.overrideAttrs (oldAttrs: {
      configureFlags = oldAttrs.configureFlags ++ [
        "--with-xkb-bin-directory=${xkbcomp}/bin"
        "--with-xkb-path=${xkb_patched}/share/X11/xkb"
      ];
    });
    setxkbmap = super.xorg.setxkbmap.overrideAttrs (oldAttrs: {
      postInstall = ''
        mkdir -p $out/share
        ln -sfn ${xkb_patched}/etc/X11 $out/share/X11
      '';
    });
    xkbcomp = super.xorg.xkbcomp.overrideAttrs (oldAttrs: {
      configureFlags = oldAttrs.configureFlags
        ++ [ "--with-xkb-config-root=${xkb_patched}/share/X11/xkb" ];
    });
  };
  ckbcomp = super.ckbcomp.override { xkeyboard_config = self.xkb_patched; };
  xkbvalidate = super.xkbvalidate.override {
    libxkbcommon =
      super.libxkbcommon.override { xkeyboard_config = xorg.xkb_patched; };
  };
}
