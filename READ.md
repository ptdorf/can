# Can

A small cli tool that stores encrypted goods.

It uses symmetric cryptography with the cipher `AES-256-CBC`. The file database
of secrets is ascii based so feel free to commit it.


# Installation

    gem install can


# Usage

    % can set test ok       # Stores a secret
    Key test was stored.
    % can get test          # Copy that secret to the clipboard
    Password:
    Key test was copied to the clipboard.


## Commands

    % can
    Commands:
      can decrypt DATA         # Decrypts data
      can encrypt DATA         # Encrypts data
      can get KEY              # Copies a KEY to the clipboard
      can help [COMMAND]       # Describe available commands or one specific command
      can ls [TAG]             # Lists all keys (filter optionally by TAG)
      can password             # Change the can password
      can random [LENGTH]      # Generates a random password
      can rename KEY NEW_NAME  # Renames a secret
      can rm KEY               # Removes a key
      can set KEY [VALUE]      # Stores a value (empty VALUE show the prompt; use '@rando...
      can tag KEY TAG          # Tags a key
      can tags [KEY]           # Show all tags (filter for a key)
      can untag KEY TAG        # Untags a tag from a key
      can version              # Show the current version

    Options:
      -p, [--password=PASSWORD]
      -v, [--verbose], [--no-verbose]
      -f, [--file=FILE]


## Using another can file

Use the `CAN_FILE` environment variable or pass the `--file FILE` or `-f FILE`
param option to use another can file:

    % export CAN_FILE="$HOME/secrets/main.can"
    % can ls --file $HOME/secrets/main.can
    % can ls -f $HOME/secrets/main.can
    aws-root
    azure-aad
    vpn-demo


## Default lookup files

If you don't pass an explicit `--file` or `-f` the default ones are checked in
order. The first one to exist is used:

    ~/.config/can/main.can
    ~/.can


## Default lookup directories

If you pass an explicit file (via the `--file` or `-f` flags) *without* a `.can`
file extension the following directories are checked. The first one to have a
file that exists with a `<dir>/<file>.can` match is used:

    ~/.config/can
    /etc/can


## Avoid the password prompt

Use the `CAN_PASSWORD` environment variable to avoid the password prompt:

    % export CAN_PASSWORD="secret"
    % can ls
    aws-root
    azure-aad
    vpn-demo

Or pass it as a arg option (`-p` or `--password`):

    % can ls -p secret
    aws-root
    azure-aad
    vpn-demo
