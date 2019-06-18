{ pkgs ? import <nixpkgs> { }, ... }:
with pkgs;
(rWrapper.override {
  packages = with rPackages; [
    dplyr
    reticulate
    ggplot2
    reshape2
    rmarkdown
    knitr
    tufte
    devtools
  ];
})
