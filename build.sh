#!/bin/bash

build() {
    pushd $1
    pushd $3
    # Incremental build
    # latexmk -output-directory=.build -c
    latexmk -pdf -interaction=nonstopmode -output-directory=.build -halt-on-error $2.tex
    popd
    popd
    cp $1/$3/.build/$2.pdf .pdf/
}

[ -d .pdf ] || mkdir .pdf

build linear_algebra linear_algebra source
build linear_algebra linear_algebra_colloquium colloquium
build mathematical_analysis mathematical_analysis_colloquium_01 .
build mathematical_analysis mathematical_analysis_colloquium_02 .
build discrete_mathematics discrete_mathematics_colloquium .
