# Can

Can stores encrypted goods using symmetric cryptography.


### Installation

    gem install can


### Usage

    % can test ok       # Store a secret
    % can test          # Copy that secret to the clipboard
    Password:
    The value for test was copied.


### Commands

    % ./bin/can
    % ./bin/can
    Commands:
      can cat              # Shows all content
      can decrypt DATA     # Decrypts data
      can encrypt DATA     # Encrypts data
      can get KEY          # Copies a key
      can help [COMMAND]   # Describe available commands or one specific command
      can ls               # Lists all keys
      can password         # Change the can password
      can random [LENGTH]  # Generates a base36 random password
      can rename KEY NAME  # Renames a secret
      can rm KEY           # Removes a key
      can set KEY [VALUE]  # Stores or updates a key (use '@random' for a random password)
      can version          # Show current version

    Options:
      -p, [--password=PASSWORD]


### Avoid typing the password

    % export CAN_PASSWORD="word"
    % can cat
    KEY         VALUE
    aws-root    xxx
    azure-aad   xxx
    vpn-demo    xxx


### Deploy

Just run:

    rake
