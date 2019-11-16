#!/bin/bash

build() {
    pushd $1
    pushd $2
    latexmk -pdf -interaction=nonstopmode -output-directory=.build -halt-on-error $3.tex
    latexmk -output-directory=.build -c
    popd
    cp $2/.build/$3.pdf $1.pdf
    popd
}

build linear_algebra source main
build mathematical_analysis . mathematical_analysis
