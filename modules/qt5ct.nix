{ lib, pkgs, config, ... }:
with lib;
let cfg = config.qt5ct;
in {
  options.qt5ct = {
    enable = mkEnableOption "Configure QT using Qt5ct";
    impure = mkOption {
      type = types.bool;
      default = false;
      description = "Allow changing settings through the qt5ct application";
    };
    theme.package = mkOption {
      type = types.package;
      default = pkgs.breeze-qt5;
      description = "Package containing the QT theme";
    };
    iconTheme.package = mkOption {
      type = types.package;
      default = pkgs.breeze-icons;
      description = "Package containing the QT icon theme";
    };
    fonts.general.package = mkOption {
      type = types.package;
      default = pkgs.dejavu-fonts;
      description =
      "Packages containing the modular-width font used in QT apps";
    };
    fonts.fixed.package = mkOption {
      type = types.package;
      default = pkgs.dejavu-fonts;
      description = "Packages containing the fixed-width font used in QT apps";
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.impure;
        message = ''
          Pure configuration of QT themes is not yet supported. You will have to run qt5ct yourself.
        '';
      }
      {
        assertion = config.xsession.enable;
        message = ''
          QT configuration currently only works reliably for the home-manager xsession.
        '';
      }
    ];

    home.sessionVariables = { "QT_QPA_PLATFORMTHEME" = "qt5ct"; };
    home.packages = [
      pkgs.qt5ct
      cfg.theme.package
      cfg.iconTheme.package
      cfg.fonts.general.package
      cfg.fonts.fixed.package
    ];
  };
}
