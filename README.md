# Remote Execution Console (REC)

--

## Overview

A lightweight shell-based tool for managing and executing remote SSH commands across grouped hosts with user interaction and logging.

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
- `ssh` command-line tool
- `curl`, `unzip` (for auto-downloading tools like PuTTY's `plink` on Windows environments)

### Run the Console

```bash
chmod +x rec
sh rec
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

Choose whether to execute commands

Enter command/script to run remotely

Output and logs will be displayed and stored
