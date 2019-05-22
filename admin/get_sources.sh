#!/bin/bash

STM_OE_REPOSITORY="https://github.com/STMicroelectronics/oe-manifest.git"
RELEASE=$1

# check this is ubuntu
if [[ $(lsb_release -i)  == *"buntu"* ]]; then
    echo ""
else
    echo "This script works on ubuntu only."
    exit 1
fi

# install repo if not installed
if ! dpkg -l repo &> /dev/null ; then
    sudo apt update
    sudo apt install repo -y
fi

if [ ! -d $RELEASE ]; then
    mkdir $RELEASE
fi

# Download openstlinux repo
cd $RELEASE
echo "Downloading "$RELEASE
repo init -u $STM_OE_REPOSITORY -b refs/tags/$RELEASE
repo sync
cd ..
