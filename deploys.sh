#!/bin/bash
# thanks to https://stackoverflow.com/questions/42253765/getting-travisci-to-commit-and-push-a-modified-file-with-tags-releases/42299765#42299765
# and https://gist.github.com/domenic/ec8b0fc8ab45f39403dd 
YEAR=$(date +"%Y")
MONTH=$(date +"%m")
git config --global user.email "${GIT_EMAIL}"
git config --global user.name "${GIT_NAME}"
git remote set-url origin https://${GITHUB_TOKEN}@github.com/sblack4/sblack4.github.io.git
# export GIT_TAG=V2.$YEAR-$MONTH.$TRAVIS_BUILD_NUMBER
# git fetch --tags
# msg="Tag Generated from TravisCI for build $TRAVIS_BUILD_NUMBER"
# if git tag $GIT_TAG -a -m "$msg" 2>/dev/null; then
# git tag $GIT_TAG -a -m "Tag Generated from TravisCI for build $TRAVIS_BUILD_NUMBER"
# git push origin master && git push origin master --tags
# ls -aR
cd src/public
echo in $(pwd)
git push origin master 
echo done