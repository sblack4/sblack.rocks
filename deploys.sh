#!/bin/bash
# thanks to https://stackoverflow.com/questions/42253765/getting-travisci-to-commit-and-push-a-modified-file-with-tags-releases/42299765#42299765
YEAR=$(date +"%Y")
MONTH=$(date +"%m")
git config --global user.email "${GIT_EMAIL}"
git config --global user.name "${GIT_NAME}"
git config --global push.default simple
echo "${GITHUB_TOKEN}" | sudo -S git remote set-url origin https://github.com/sblack4/sblack4.github.io.git
# export GIT_TAG=V2.$YEAR-$MONTH.$TRAVIS_BUILD_NUMBER
 git fetch --tags
# msg="Tag Generated from TravisCI for build $TRAVIS_BUILD_NUMBER"
# if git tag $GIT_TAG -a -m "$msg" 2>/dev/null; then
# git tag $GIT_TAG -a -m "Tag Generated from TravisCI for build $TRAVIS_BUILD_NUMBER"
# git push origin master && git push origin master --tags
# ls -aR
cd src/public
echo in $(pwd)
git push origin master 
echo done