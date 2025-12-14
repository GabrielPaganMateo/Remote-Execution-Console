isPasswordBasedOrSSH() {
    SSH=$(askForInput "Do you have SSH key pair configured in remote server ? (y/n)")
    case $SSH in
        y|Y)
            # Do Nothing
            ;;
        n|N)
            PASS=$(askForInput "Please provide password : ")
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