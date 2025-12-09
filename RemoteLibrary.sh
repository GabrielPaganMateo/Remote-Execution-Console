log() {
    printf ":: %s\n" "$1" 
}

errorLog() {
    echo "-> " "$1"
}

askForInput() {
    read -p ":: $1 " input
    echo "$input"
}

askForCredentials() {
    REMOTEHOST=$(askForInput "What is the remote host URL ?")
    REMOTEUSER=$(askForInput "Who is the user ?")
}

TOOL_DIR="./plink.tool"

downloadPasswordConnectionTool() {
    if [ ! -f "$TOOL_DIR/plink.exe" ]; then
        log "Installing PuTTY Link for password connection..."
        mkdir $TOOL_DIR

        TOOL_URL="https://the.earth.li/~sgtatham/putty/latest/w64/putty.zip"
        if command -v curl >/dev/null; then
            curl -L -o $TOOL_DIR/putty.zip "$TOOL_URL"
        elif command -v wget >/dev/null; then
            wget "$TOOL_URL"
        else
            errorLog "Error: curl or wget required"
            exit 1
        fi

        unzip -o $TOOL_DIR/putty.zip -d $TOOL_DIR >/dev/null

        if [[ ! -f "$TOOL_DIR/plink.exe" ]]; then
            errorLog "Failed to extract plink.exe"
            exit 1
        fi
        echo -e "\n"
    fi
}

# removeTemporaryTools() {
#     rm -rf "$TMP_TOOL_DIR"
#     rm -rf ./tmp.*
# }

sshConnectAndExecute() {
    echo "Connecting..."
    test -z "$1" && connection_output=$(ssh $REMOTEUSER@$REMOTEHOST 'echo SHH')
    # SSH PASSWORD WILL NOT WORK IN WINDOWS, ONLY LINUX LIBRARIES CAN BE INSTALLED FOR THAT BUT INCOMPATIBLE WITH WINDOWS. 
    # MAYBE I CAN USE plink.exe work around, but that is a PUTTY command , the script would be incompatible for LINUX. I would have make the script identify the runtime environment, whether it is LINUX or WINDOWS,
    # then install the required libraries/tools and continue with script execution.
    # use the ideas from the following script downloadPuttyToolAndExecuteRemoteCommand.sh
    #test -n "$1" && connection_output=$(sshpass -p "$1" ssh $REMOTEUSER@$REMOTEHOST 'echo SSHPASS')
    test -n "$1" && connection_output=$("$TOOL_DIR"/PLINK.EXE -ssh -pw "$1" "$REMOTEUSER@$REMOTEHOST" "echo PLINK")
    echo "$1"
    echo "$connection_output"
}

passwordConnectAndExecute() {
    downloadPasswordConnectionTool
    log "Connecting to ${REMOTEUSER}@${REMOTEHOST}"
    log "Executing : $2"
    log "Please follow any connection tool instructions..."
    echo -e "/n"
    test -n "$1" && connection_output=$("$TOOL_DIR"/PLINK.EXE -ssh -pw "$1" "$REMOTEUSER@$REMOTEHOST" "$2")
    # removeTemporaryTools
}

isPasswordBasedOrSSH() {
    SSH=$(askForInput "Do you have SSH key pair configured in remote server ? (y/n)")
    case $SSH in
        y|Y)
            sshConnectAndExecute
            ;;
        n|N)
            PWD=$(askForInput "Please provide password : ")
            CMD=$(askForInput "Input the desired command or path to script : ")
            passwordConnectAndExecute "$PWD" "$CMD"
            ;;
        *) 
            errorLog "Please answer with y (yes) or n (no)"
            isPasswordBasedOrSSH
            ;;
    esac
}

askForOneTimeConnection() {
    ONCE=$(askForInput "Would you like to establish a one time connection? (y/n)")
    case $ONCE in
        y|Y) 
            askForCredentials
            isPasswordBasedOrSSH
            ;;
        n|N) 
            log "Goodbye."
            exit 0
            ;;
        *) 
            errorLog "Please answer with y (yes) or n (no)"
            askForOneTimeConnection
            ;;
    esac
}

createConfigurationOrEstablishConnection() {
    CREATE=$(askForInput "Would you like to create it? (y/n)")
    case $CREATE in
        y|Y) 
            exit 0
            ;;
        n|N) 
            askForOneTimeConnection
            ;;
        *) 
            errorLog "Please answer with y (yes) or n (no)"
            createConfigurationOrEstablishConnection
            ;;
    esac
}

checkRemoteConfiguration() {
    # Check if configuration settings exist for remote directory
    REMOTECONFIG="./.remote"
    if [ ! -f ".remote" ]
    then
        log "Remote server configuration file does not exist"
        createConfigurationOrEstablishConnection
    fi
}