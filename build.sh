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

# build [working directory] [.tex file base name]
build course-1/algebra algebra-exam
build course-1/linear-algebra/lectures linear-algebra
build course-1/linear-algebra/colloquium linear-algebra-colloquium-1
build course-1/linear-algebra/colloquium linear-algebra-colloquium-2
build course-1/linear-algebra/colloquium linear-algebra-exam-definitions-2
build course-1/mathematical-analysis mathematical-analysis-colloquium-1
build course-1/mathematical-analysis mathematical-analysis-colloquium-2
build course-1/mathematical-analysis mathematical-analysis-colloquium-3
build course-1/mathematical-analysis mathematical-analysis-colloquium-4
build course-1/mathematical-analysis mathematical-analysis-exam-1
build course-1/discrete-mathematics discrete-mathematics-colloquium-1
build course-1/discrete-mathematics discrete-mathematics-colloquium-2
