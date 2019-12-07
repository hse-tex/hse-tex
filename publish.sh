#!/bin/bash
set -e

# branch=$(git rev-parse --abbrev-ref HEAD)
# 
# git fetch origin gh-pages:gh-pages
# git checkout gh-pages
# 
# # relying on .pdf not being touched by git)00)00)0
# cp -r .pdf/* .
# 
# # copy README from master
# git checkout master README.md
# 
# git add -A
# git commit -m "${TRAVIS_COMMIT_MESSAGE:=pdf updates}"
# git push origin gh-pages
# 
# git checkout $branch


git clone --branch gh-pages git@github.com:LoDThe/hse-tex.git _gh_pages
pushd _gh_pages

cp -r ../.pdf/* .
cp ../README.md .

git add -A
git commit -m "${TRAVIS_COMMIT_MESSAGE:=pdf updates}"
git push origin gh-pages

popd
