# Can

Can stores encrypted goods using symmetric cryptography.


### Installation

    gem install can


### Usage

    % can set test ok       # Store a secret
    % can get test          # Copy that secret to the clipboard
    Password:
    The value for test was copied.


### Commands

    % ./bin/can
    Commands:
      can cat                 # Shows all content
      can decrypt DATA        # Decrypts data
      can encrypt DATA        # Encrypts data
      can get KEY             # Copies a key to the clipboard
      can help [COMMAND]      # Describe available commands or one specific command
      can ls                  # Lists all keys
      can password            # Change the can password
      can random [LENGTH]     # Generates a base36 random password
      can rename KEY NEW_KEY  # Renames a secret
      can rm KEY              # Removes a key
      can set KEY [VALUE]     # Stores a value (leave the value empty for a prompt; use '@random' for a random value)
      can version             # Show current version

    Options:
      -p, [--password=PASSWORD]


### Avoid typing the password

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


### Deploy

Just run:

    rake
