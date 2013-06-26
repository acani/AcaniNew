#!/bin/sh

# Update Facebook.
if cd Libraries/FacebookSDK; then
    if git checkout master &&
        git fetch origin master &&
        [ `git rev-list HEAD...origin/master --count` != 0 ] &&
        git merge origin/master &&
        sh scripts/build_framework.sh
    then
        rm -rf ../FacebookSDK.framework
        mv -v build/FacebookSDK.framework ../
        git clean -dXf
        cd ../..
        git add -A Libraries/FacebookSDK*
        git commit -am 'Update FacebookSDK.'
        exit
    fi
    cd ../..
fi
