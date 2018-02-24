{ pkgs ? import <nixpkgs> {}, ... }:
with pkgs;
( rWrapper.override {
            packages = with rPackages; [
                dplyr
                ggplot2
                reshape2
				rmarkdown
                ];
        }
)
