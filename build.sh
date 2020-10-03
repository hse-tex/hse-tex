#!/bin/bash
set -e

if [[ ! -f documents.yml ]]; then
    echo "No documents.yml, cant build anyting"
    exit -1
fi

if [[ -r _gh_pages/.git-revision ]]; then
    prev_revision=$(cat _gh_pages/.git-revision)
fi

function get_dependencies {
    mode=$1
    source=$2
    
    case "$mode" in
        single) arg="-s" ;;
        directory) arg="-d" ;;
    esac

    python3 get-build-dependencies.py $arg $source
}

function check_diff {
    [[ -z "$CHECK_DIFF" ]] && return 0

    # always build without prev revision
    if [[ -z "$prev_revision" ]]; then
        echo "Could not find previous revision"
        return 0
    fi

    ! git diff --quiet $prev_revision $@
    return $?
}

function build_item {
    mode=$1; shift
    source=$1; shift
    target=$1; shift
    
    echo Trying to build $source into $target with mode $mode

    workdir=$(dirname $source)
    filename=$(basename $source)
    filename_without_ext="${filename%.*}"

    [ -z "$CI" ] || echo "::group::Build $filename"
    if check_diff $(get_dependencies $mode $source); then
        pushd $workdir > /dev/null
        latexmk -pdf -interaction=nonstopmode -output-directory=.build -file-line-error -halt-on-error $filename
        popd > /dev/null

        mkdir -p .pdf/$(dirname $target)
        cp $workdir/.build/$filename_without_ext.pdf .pdf/$target
    else
        echo No diff found, skipping build!
    fi
    [ -z "$CI" ] || echo "::endgroup::"
}

function build_type {
    mode=$1

    jq -c ".$mode[]" <(yq . documents.yml) | while read item; do
        source=$(jq .source -r <<< $item)
        target=$(jq .target -r <<< $item)

        build_item $mode $source $target
    done
}

build_type single
build_type directory
