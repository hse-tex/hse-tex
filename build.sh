#!/bin/bash
set -e

if [[ -r _gh_pages/.git-revision ]]; then
    prev_revision=$(cat _gh_pages/.git-revision)
fi

function check_diff {
    [[ -z "$CHECK_DIFF" ]] && return 0

    # always build without prev revision
    [[ -z "$prev_revision" ]] && return 0

    ! git diff --quiet $prev_revision $@
    return $?
}

function build {
    workdir=$1
    basename=$2

    if check_diff $workdir; then
        pushd $workdir > /dev/null
        [ -z "$CI" ] || echo "::group::Build $basename"
        latexmk -pdf -interaction=nonstopmode -output-directory=.build -file-line-error -halt-on-error $basename.tex
        [ -z "$CI" ] || echo "::endgroup::"
        popd > /dev/null
        cp $workdir/.build/$basename.pdf .pdf/
    fi
}

[ -d .pdf ] || mkdir .pdf

build algebra algebra_exam
build linear_algebra/source linear_algebra
build linear_algebra/colloquium linear_algebra_colloquium_1
build linear_algebra/colloquium linear_algebra_colloquium_2
build linear_algebra/colloquium linear_algebra_exam_definitions_2
build linear_algebra/colloquium only-titles
build mathematical_analysis mathematical_analysis_colloquium_01
build mathematical_analysis mathematical_analysis_colloquium_02
build mathematical_analysis mathematical_analysis_colloquium_03
build mathematical_analysis mathematical_analysis_colloquium_04
build mathematical_analysis mathematical_analysis_exam_01
build discrete_mathematics discrete_mathematics_colloquium_01
build discrete_mathematics discrete_mathematics_colloquium_02
