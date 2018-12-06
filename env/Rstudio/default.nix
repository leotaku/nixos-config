{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
( rstudioWrapper.override {
            packages = with rPackages; [
              dplyr
              reticulate
              ggplot2
              reshape2
              rmarkdown
              knitr
            ];
        }
)
