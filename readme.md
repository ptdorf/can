# Can

Stores encrypted goods.


### Installation

    gem install can


### Usage

    % can
    Commands:
      can cat              # Shows all content
      can decrypt DATA     # Decrypts data
      can encrypt DATA     # Encrypts data
      can get KEY          # Copies a key
      can help [COMMAND]   # Describe available commands or one specific command
      can ls               # Lists all keys
      can rm KEY           # Removes a key
      can set KEY [VALUE]  # Stores a key
      can version          # Show current version

    Options:
      -p, [--password=PASSWORD]

### Example

    % can test ok       # Store secret
    % can test          # Copy that secret
    Password:
    The value for test was copied.
