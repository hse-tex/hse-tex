#!/bin/bash
set -e

git clone --branch gh-pages git@github.com:LoDThe/hse-tex.git _gh_pages
pushd _gh_pages

cp -r ../.pdf/* .
cp ../README.md .

git add -A
git commit -m "${TRAVIS_COMMIT_MESSAGE:=pdf updates}"
git push origin gh-pages

popd
