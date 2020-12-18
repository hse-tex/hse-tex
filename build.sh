#!/bin/bash
set -e

if [[ ! -f documents.yml ]]; then
    echo "No documents.yml, cant build anything"
    exit -1
fi

if [[ -r _gh_pages/.git-revision ]]; then
    prev_revision=$(cat _gh_pages/.git-revision)
elif [[ ! -z "$GITHUB_BASE_REF" ]]; then
    prev_revision="$GITHUB_BASE_REF"
else
    echo "No prev revision"
fi

# fetch base revision for diff check
if [[ ! -z "$CHECK_DIFF" ]] && [[ ! -z "$prev_revision" ]]; then
    echo "Fetching $prev_revision"
    git fetch --force origin "$prev_revision":refs/heads/diff-base 2> /dev/null
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

    ! git diff --quiet diff-base $@
    return $?
}

function build_item {
    mode=$1; shift
    source=$1; shift
    target=$1; shift

    workdir=$(dirname $source)
    filename=$(basename $source)
    filename_without_ext="${filename%.*}"

    if check_diff $(get_dependencies $mode $source); then
        [ -z "$CI" ] || echo "::group::Build $filename"
        echo Trying to build $source into $target with mode $mode

        pushd $workdir > /dev/null
        latexmk -pdf -interaction=nonstopmode -file-line-error -halt-on-error $filename
        popd > /dev/null

        mkdir -p .pdf/$(dirname $target)
        cp $workdir/$filename_without_ext.pdf .pdf/$target
    
        [ -z "$CI" ] || echo "::endgroup::"
    else
        echo No diff found, skipping $source
    fi
}

for mode in single directory; do
    jq -c ".$mode[]" <(yq . documents.yml) | while read item; do
        source=$(jq .source -r <<< $item)
        target=$(jq .target -r <<< $item)

        build_item $mode $source $target
    done
done