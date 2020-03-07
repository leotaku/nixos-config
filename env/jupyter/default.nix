let
  sources = import ../../sources/nix/sources.nix;
  jupyter = import sources.jupyterWith {};

  ipython = jupyter.kernels.iPythonWith {
    name = "default";
    packages = p: with p; [ numpy matplotlib ];
  };

  jupyterEnvironment = jupyter.jupyterlabWith { kernels = [ ipython ]; };
in jupyterEnvironment.env
