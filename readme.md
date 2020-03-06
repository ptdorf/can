# Can

A small cli tool that stores encrypted goods.

It uses symmetric cryptography with the cipher `AES-256-CBC`. The file database
of secrets is ascii based so feel free to commit it.


## Installation

    gem install can


### Usage

    % can set test ok       # Stores a secret
    Key test was stored.
    % can get test          # Copy that secret to the clipboard
    Password:
    Key test was copied to the clipboard.


### Commands

    % can
    Commands:
      can cat                 # Shows all content
      can decrypt DATA        # Decrypts data
      can encrypt DATA        # Encrypts data
      can get KEY             # Copies a key to the clipboard
      can help [COMMAND]      # Describe available commands or one specific command
      can ls [TAG]            # Lists all keys (filter optionally by tag
      can migrate             # Migrates to new format
      can password            # Change the can password
      can random [LENGTH]     # Generates a base36 random password
      can rename KEY NEW_KEY  # Renames a secret
      can rm KEY              # Removes a key
      can set KEY [VALUE]     # Stores a value (leave the value empty for a prompt; use '@random' for a random value)
      can tag KEY TAG         # Tags a key
      can tags [KEY]          # Show all tags (filter for a key)
      can untag KEY TAG       # Untags a tag from a key
      can version             # Show current version

    Options:
      -p, [--password=PASSWORD]
      -v, [--verbose], [--no-verbose]
      -f, [--file=FILE]


### Using another can file

Use the `CAN_FILE` environment variable or pass the `--file FILE` or `-f FILE`
param option to use another can file:

    % export CAN_FILE="$HOME/secrets/main.can"
    % can ls --file $HOME/secrets/main.can
    % can ls -f $HOME/secrets/main.can
    aws-root
    azure-aad
    vpn-demo


### Avoid the password prompt

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
