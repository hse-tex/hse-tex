#!/bin/bash

build() {
    pushd $1
    # Incremental build
    # latexmk -output-directory=.build -c
    latexmk -pdf -interaction=nonstopmode -output-directory=.build -halt-on-error $2.tex
    popd
    cp $1/.build/$2.pdf .pdf/
}

[ -d .pdf ] || mkdir .pdf

build linear_algebra/source linear_algebra
build linear_algebra/colloquium linear_algebra_colloquium
build mathematical_analysis mathematical_analysis_colloquium_01
build mathematical_analysis mathematical_analysis_colloquium_02
build discrete_mathematics discrete_mathematics_colloquium
