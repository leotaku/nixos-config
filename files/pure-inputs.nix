let
  flake = builtins.getFlake (builtins.toString ../.);
in flake.inputs
