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

# USE FOR CMD validation before executing SSH 
# if has unmatched quotes then retry command input and log with recommendations
# Maybe one of the following two logs
# :: please be cautious when inputting commands, as best practice copy/paste the entire command at once
# :: please be cautious when inputting commands with quotes, as best practice copy/paste the entire command at once
# has_unmatched_quotes() {
#     local s="$1"
#     local dq=${s//[^"]/}
#     local sq=${s//[^']/}

#     (( ${#dq} % 2 != 0 || ${#sq} % 2 != 0 ))
# }

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
    log "Connecting to ${REMOTEUSER}@${REMOTEHOST}"
    log "Executing : $1"
    echo

    test -n "$1" && [ ! -f "$1" ] && connection_output=$(ssh $REMOTEUSER@$REMOTEHOST "$1")
    test -n "$1" && [ -f "$1" ] && connection_output=$(ssh $REMOTEUSER@$REMOTEHOST "sh -s" < "$1")

    echo
    test -n "$connection_output" && log "Output > $connection_output"
}

passwordConnectAndExecute() {
    downloadPasswordConnectionTool
    log "Connecting to ${REMOTEUSER}@${REMOTEHOST}"
    log "Executing : $2"
    echo

    test -n "$1" && [ ! -f "$2" ] && connection_output=$("$TOOL_DIR"/PLINK.EXE -ssh -pw "$1" "$REMOTEUSER@$REMOTEHOST" "$2")
    test -n "$1" && [ -f "$2" ] && connection_output=$("$TOOL_DIR"/PLINK.EXE -ssh -pw "$1" "$REMOTEUSER@$REMOTEHOST" "sh -s" < "$2")
    
    echo
    test -n "$connection_output" && log "Output > $connection_output"
}

isPasswordBasedOrSSH() {
    SSH=$(askForInput "Do you have SSH key pair configured in remote server ? (y/n)")
    case $SSH in
        y|Y)
            #CMD=$(askForInput "Input the desired command or path to script : ")
            # sshConnectAndExecute "$CMD"
            ;;
        n|N)
            PASS=$(askForInput "Please provide password : ")
            #CMD=$(askForInput "Input the desired command or path to script : ")
            # passwordConnectAndExecute "$PWD" "$CMD"
            ;;
        *) 
            errorLog "Please answer with y (yes) or n (no)"
            isPasswordBasedOrSSH
            ;;
    esac
}

askForOneTimeCommand() {
    ONCE=$(askForInput "Would you like to execute a one time command? (y/n)")
    case $ONCE in
        y|Y) 
            askForCredentials
            isPasswordBasedOrSSH
            CMD=$(askForInput "Input the desired command or path to script : ")
            test -z "$PASS" && sshConnectAndExecute "$CMD"
            test -n "$PASS" && passwordConnectAndExecute "$PASS" "$CMD"
            ;;
        n|N) 
            log "Goodbye."
            exit 0
            ;;
        *) 
            errorLog "Please answer with y (yes) or n (no)"
            askForOneTimeCommand
            ;;
    esac
}

createRemoteConfiguration() {
    exit 0
}

createConfigurationOrEstablishConnection() {
    CREATE=$(askForInput "Would you like to create it? (y/n)")
    case $CREATE in
        y|Y) 
            createRemoteConfiguration
            ;;
        n|N) 
            askForOneTimeCommand
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