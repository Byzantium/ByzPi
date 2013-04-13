#!/bin/bash

basedir=$(realpath `dirname $0`)
codename="wheezy"

CWD=`pwd`

cd $basedir #enter apt repo
reprepro includedeb $codename ../*.deb # add debs to repo
git add -A # add new files and stage changes
git commit -a -m"auto-commit:add-deb.sh adding packages see log for details" # commit changes

cd $CWD
echo don't foget to push your changes once you've made sure they are correct
