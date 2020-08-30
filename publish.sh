#!/bin/bash
set -e

function get_commit_message {
    if [[ -n "$GITHUB_SHA" ]]; then
        echo $(git log --format=%B -n 1 $GITHUB_SHA)
    fi
    echo "pdf updates"
}

if [[ ! -d _gh_pages ]]; then
    git clone --branch gh-pages git@github.com:hse-tex/hse-tex.git _gh_pages
fi

commit_message=$(get_commit_message)
git rev-parse HEAD > _gh_pages/.git-revision

pushd _gh_pages

cp -r ../.pdf/* .
cp ../README.md .

git add -A

if git diff --quiet; then
    author=${GITHUB_ACTOR:=github-actions}
    git config user.name "$author"
    git config user.email "$author@users.noreply.github.com"

    git commit --allow-empty -m "$commit_message"
    git push origin gh-pages
fi

popd
