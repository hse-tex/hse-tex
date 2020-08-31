#!/bin/bash
set -e

if [[ ! -f documents.yml ]]; then
    echo "No documents.yml, cant build anyting"
    exit -1
fi

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

function build_item {
    source=$1; shift
    target=$1; shift

    workdir=$(dirname $source)
    filename=$(basename $source)
    filename_without_ext="${filename%.*}"

    if check_diff $@; then
        pushd $workdir > /dev/null
        [ -z "$CI" ] || echo "::group::Build $filename"
        latexmk -pdf -interaction=nonstopmode -output-directory=.build -file-line-error -halt-on-error $filename
        [ -z "$CI" ] || echo "::endgroup::"
        popd > /dev/null

        mkdir -p .pdf/$(dirname $target)
        cp $workdir/.build/$filename_without_ext.pdf .pdf/$target
    fi
}

function build {
    mode=$1
    source=$2
    target=$3

    if [[ $mode = "directory" ]]; then
        build_item $source $target \
            $(dirname $source) \
            $(dirname $source)/*header.sty \
            $(dirname $source)/../*header.sty \
            $(dirname $source)/../../*header.sty \
            $(dirname $source)/../../../*header.sty \
            $(dirname $source)/../../../../*header.sty
    elif [[ $mode = "single" ]]; then
        build_item $source $target \
            $(dirname $source)/*header.sty \
            $(dirname $source)/../*header.sty \
            $(dirname $source)/../../*header.sty \
            $(dirname $source)/../../../*header.sty \
            $(dirname $source)/../../../../../*header.sty
    fi
}

function build_type {
    mode=$1

    keys=$(yq .$mode' | keys[]' documents.yml)

    mapfile -t source < <(yq .$mode[].source documents.yml -r)
    mapfile -t target < <(yq .$mode[].target documents.yml -r)

    for key in $keys; do
        build $mode ${source[$key]} ${target[$key]}
    done
}

build_type single
build_type directory
