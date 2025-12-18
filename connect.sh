#!/bin/sh

DIR=$(dirname $0)
cd "$DIR"

TODAY=$(date +"%Y-%m-%d")
LOGFILE="rec.${TODAY}.log"
LOGDIR="./logs/"
LOG=${LOGDIR}${LOGFILE}

NOW=$(date +"%Y-%m-%d(%H:%M:%S)")

echo "Remote Execution Console -> $NOW" >> $LOG

REMOTECONFIG="./.remote"

source ./libs/log.lib
source ./libs/input.lib
source ./libs/execution.lib
source ./libs/console.lib

OPTIONS="h"

while getopts "$OPTIONS" option
do
    case $option in
        h)
            echo "Usage: [-h] "
            exit 0
            ;;
    esac
done

checkRemoteConfiguration
