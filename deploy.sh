#!/bin/bash
set -e

tee ~/.netrc > /dev/null <<EOF
machine github.com
login video-bot
password $GH_TOKEN
EOF

git remote add deploy https://github.com/LeifAndersen/leifandersen.github.io.git
git config --global user.email "website@video-lang.org"
git config --global user.name "Video Bot"

REV="** deploy videolang/website@$TRAVIS_COMMIT"
git fetch deploy
git reset --soft deploy/master
git checkout HEAD -- README.md
git checkout HEAD -- .gitignore
git add .
git status
git commit -m "$REV"

git fetch origin
CURRENT_HEAD=`git rev-parse origin/master`
if [ "$TRAVIS_COMMIT" = "$CURRENT_HEAD" ]
then
    echo "Committing..."
    git push deploy HEAD:refs/heads/master
else
    echo "Aborting; detected race..."
    exit 1
fi
