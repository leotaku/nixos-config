{ config, lib, pkgs, ... }:

{
  options = {
    variables = lib.mkOption {
      description = "Unstructured set of shared options.";
      default = { };
      type = with lib.types; attrsOf anything;
    };
  };
}
