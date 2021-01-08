# Can

A small cli tool that stores encrypted goods.

It uses symmetric cryptography with the cipher `AES-256-CBC`. The file database
of secrets is ascii based so feel free to commit it.


# Installation

    gem install can


# Usage

    $ can set test ok       # Stores a secret
    Key test was stored.
    $ can get test          # Copy that secret to the clipboard
    Password:
    Key test was copied to the clipboard.


## Commands

```bash
$ can
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
```


## Using another can file

Use the `CAN_FILE` environment variable or pass the `--file FILE` (or `-f FILE`)
param option to use another can file:

```bash
$ export CAN_FILE="$HOME/secrets/main.can"
$ can ls
aws-root
azure-aad
vpn-demo

$ can ls --file $HOME/secrets/main.can
aws-root
azure-aad
vpn-demo
```

## Lookup chain

If you don't pass an explicit `--file` or `-f` or set the `CAN_FILE` the code
will check some locations in order. The first one to exist is used.

The code checks first these files first:

    `~/.config/can/main.can`
    `~/.can` # Legacy

The second file is legacy. By new default one is `~/.config/can/main.can`.

If you pass the `--name NAME` (or `-n NAME`) argument, the code will try to find
the first file that exists with a `<NAME>.can` name in these directories:

    `~/.config/can`
    `/etc/can`

The first one to exist is used. You can also set the `CAN_NAME` environment
variable instead too. As usual, cli arguments override environment variables.


## Avoid the password prompt

Use the `CAN_PASSWORD` environment variable to avoid the password prompt:

    $ export CAN_PASSWORD="secret"
    $ can ls
    aws-root
    azure-aad
    vpn-demo

Passing the password as an arg option (`--password PASSWORD` or `-p PASSWORD`)
is now disabled. This prevents the password from being recorded in the shell
history.
