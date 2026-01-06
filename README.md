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
::  >> EC2 Servers
::  >> GCE Servers
::
:: To view the available connections of a group, input a group name.
:: To create a new group, use a new name.
:: To use one time credentials, press enter.
:: Group name :
```

Add connection credentials (user@host)

Choose whether to execute commands

Enter command/script to run remotely

Output and logs will be displayed and stored

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
