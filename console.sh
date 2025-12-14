#!/bin/sh

DIR=$(dirname $0)
cd "$DIR"

TODAY=$(date +"%Y-%m-%d")
LOGFILE="rec.${TODAY}.log"

NOW=$(date +"%Y-%m-%d(%H:%M:%S)")

echo "Remote Execution Console -> $NOW" >> ./logs/$LOGFILE

source ./libs/log.lib
source ./libs/input.lib
source ./libs/connect.lib
source ./RemoteLibrary.sh

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
