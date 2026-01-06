# Remote Execution Console (REC)

```text
 _____  ______ _____ 
|  __ \|  ____/ ____|
| |__) | |__ | |     
|  _  /|  __|| |     
| | \ \| |___| |____ 
|_|  \_\______\_____|
:: [ REC ] Remote Execution Console                              
```

## Overview

A simple shell-based tool for managing and executing remote SSH commands across grouped hosts.

---

## 📌 Features

- Create and manage groups of remote SSH connections
- Execute commands or scripts on one or all connections
- Interactive CLI-based input for credentials and commands
- Logging of operations and error messages
- Support for dynamic configuration of host groups

---

## 🚀 Getting Started

### Prerequisites

- Unix/Linux shell (example: Git Bash)
- `ssh`
- `curl`, `unzip`

### Usage Flow

Start remote execution console

```bash
chmod +x rec
sh rec
```

Assign or choose a connection group

```
:: The following remote server groups are available:
::
::  >> Web Servers
::  >> App Servers
::
:: To view the available connections of a group, input a group name.
:: To create a new group, use a new name.
:: To use one time credentials, press enter.
:: Group name :
```

Add connection credentials (user@host)

```
:: Let's configure a new remote connection for App Servers
:: What is the remote host URL ? ec2-52-91-140-189.compute-1.amazonaws.com
:: Who is the user ? dev
:: Do you have SSH key pair configured in remote server ? (y/n) n
:: Please provide password :  ********
::
:: Added -> dev@ec2-52-91-140-189.compute-1.amazonaws.com
::
:: Would you like to add another remote connection ? (y/n) n
```

Choose whether to execute commands

```
:: The following App Servers connections are available:
::
::  1) [dev@ec2-52-91-140-189.compute-1.amazonaws.com]
::  2) [ec2-user@ec2-54-236-21-29.compute-1.amazonaws.com]
::
:: Execute a command or script with App Servers connections ? (y/n) y
```

Enter command/script to run remotely

```
:: Let's execute a remote command in App Servers !
::
::  1) [dev@ec2-52-91-140-187.compute-1.amazonaws.com]
::  2) [ec2-user@ec2-54-236-21-27.compute-1.amazonaws.com]
::
:: To select one connection, enter an index from the list.
:: If you want to use all connections, use * as input
:: Connection number : *
:: Selected connection dev@ec2-52-91-140-189.compute-1.amazonaws.com
:: Selected connection ec2-user@ec2-54-236-21-29.compute-1.amazonaws.com
::
:: Input a command or path to script for execution :  echo Hello World!
:: Connecting to dev@ec2-52-91-140-189.compute-1.amazonaws.com
:: Executing : echo Hello World!

== Remote Shell ==
Access granted. Press Return to begin session.

Hello World!
==================

:: Execution finished.
:: Connecting to ec2-user@ec2-54-236-21-29.compute-1.amazonaws.com
:: Executing : echo Hello World!

== Remote Shell ==
Hello World!
==================

:: Execution finished.
```

Output and logs will be displayed and stored

```
Remote Execution Console -> 2026-01-06(15:03:45)
Found ./groups/remote(App Servers)
Found ./groups/remote(Web Servers)
:: [ REC ] Remote Execution Console
:: The following remote server groups are available:
:: 
::  >> App Servers
::  >> Web Servers
:: 
:: To view the available connections of a group, input a group name.
:: To create a new group, use a new name.
:: To use one time credentials, press enter.
./groups/remote(App
:: The following App Servers connections are available:
:: 
::  1) [dev@ec2-52-91-140-189.compute-1.amazonaws.com]
::  2) [ec2-user@ec2-54-236-21-29.compute-1.amazonaws.com]
:: 
:: Let's execute a remote command in App Servers !
:: 
::  1) [dev@ec2-52-91-140-189.compute-1.amazonaws.com]
::  2) [ec2-user@ec2-54-236-21-29.compute-1.amazonaws.com]
:: 
:: To select one connection, enter an index from the list.
:: If you want to use all connections, use * as input
:: Selected connection dev@ec2-52-91-140-189.compute-1.amazonaws.com
:: Selected connection ec2-user@ec2-54-236-21-29.compute-1.amazonaws.com
:: 
:: Connecting to dev@ec2-52-91-140-189.compute-1.amazonaws.com
:: Executing : echo Hello World!
Hello World!
:: Execution finished.
:: Connecting to ec2-user@ec2-54-236-21-29.compute-1.amazonaws.com
:: Executing : echo Hello World!
Hello World!
:: Execution finished.
:: 
```

---

## 📁 Project Structure

| File | Description |
|------|-------------|
| `rec` | Main execution script. Entry point to the Remote Execution Console. |
| `console.lib` | Handles user interaction, input routing, and control flow logic. |
| `execution.lib` | Manages command/script execution across remote hosts via SSH. |
| `input.lib` | Functions for prompting and receiving user inputs. |
| `log.lib` | Logging utilities and ASCII header display. |
| `remote.lib` | Utilities for managing remote host groups and configurations. |
