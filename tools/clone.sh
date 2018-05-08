#!/bin/sh

REPOSRC=$1
LOCALREPO=$2
UPDATE=$3

# We do it this way so that we can abstract if from just git later on
LOCALREPO_VC_DIR=$LOCALREPO/.git

if [ ! -d $LOCALREPO_VC_DIR ]
then
    git clone $REPOSRC $LOCALREPO
elif [ "$UPDATE" = true ]
then
    cd $LOCALREPO
    git pull $REPOSRC
fi

