#!/bin/bash
set -e 

function build {
    pushd $1 > /dev/null

    if [ ! -z "$CI" ]; then
        travis_fold start build_log
        travis_time_start
        echo -ne "\033[1;33m"
        echo -n "Build $2"
        echo -e "\033[0m"
    fi

    latexmk -pdf -interaction=nonstopmode -output-directory=.build -halt-on-error $2.tex

    if [ ! -z "$CI" ]; then
        travis_time_finish
        travis_fold end build_log
    fi
    
    popd > /dev/null

    cp $1/.build/$2.pdf .pdf/
}

[ -d .pdf ] || mkdir .pdf

build linear_algebra/source linear_algebra
build linear_algebra/colloquium linear_algebra_colloquium_1
build linear_algebra/colloquium linear_algebra_colloquium_2
build mathematical_analysis mathematical_analysis_colloquium_01
build mathematical_analysis mathematical_analysis_colloquium_02
build mathematical_analysis mathematical_analysis_colloquium_03
build mathematical_analysis mathematical_analysis_colloquium_04
build mathematical_analysis mathematical_analysis_exam_01
build discrete_mathematics discrete_mathematics_colloquium_01
build discrete_mathematics discrete_mathematics_colloquium_02
