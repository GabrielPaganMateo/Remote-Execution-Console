#!/bin/sh

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
