#!/bin/sh

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

# Check if configuration settings exist for remote directory
REMOTECONFIG="./remote.config"
if [ ! -f ""]