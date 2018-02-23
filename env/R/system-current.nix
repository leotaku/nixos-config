with import <nixpkgs> {};
( rWrapper.override {
            packages = with rPackages; [
                dplyr
                ggplot2
                reshape2
				rmarkdown
                ];
        }
)
