#!/bin/bash

build() {
    pushd $1
    pushd $3
    latexmk -pdf -interaction=nonstopmode -output-directory=.build -halt-on-error $4.tex
    latexmk -output-directory=.build -c
    popd
    cp $3/.build/$4.pdf $2.pdf
    popd
}

build linear_algebra linear_algebra source main
build linear_algebra linear_algebra_colloquium colloquium main
build mathematical_analysis mathematical_analysis . mathematical_analysis
build discrete_mathematics discrete_mathematics_colloquium . discrete_mathematics_colloquium
