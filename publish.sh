#!/bin/bash

files=$(./create_file_list.sh)

branch=$(git branch --show-current)
git checkout gh-pages

# relying on .pdf not being touched by git)00)00)0
cp -r .pdf/* .
git add -A
git commit --allow-empty -m "${TRAVIS_COMMIT_MESSAGE:=pdf updates}"
git push origin gh-pages

git checkout $branch
