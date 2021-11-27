# Software Development Tools

This role installs and configures the software I use for working.

## Requirements

This role only supports Arch Linux systems.

## Role Variables

```yaml
# Username of the main user of the system.
user_name:

# Group name of the main user of the system.
user_group:

# GPG key id used as the default GPG key for encryption and signing operations.
user_gnupg_key_id:

# User full name. Used to populate the author name in Git commits, among other things.
user_full_name:

# Author information to be used with GitHub.
user_github_username:
user_github_email:

# IRC server and username, used by emacs erc.
user_irc_nickname: ''
user_irc_server: ''
```

## Dependencies

Roles:

- `danielfm.aur`

## Example Playbook

```yaml
---

- hosts: all
  gather_facts: false
  become: true

  vars:
    user_name: jdoe
    user_group: jdoe
    user_gnupg_key_id: '0x123456789'
    user_full_name: John Doe
    user_github_username: jdoe
    user_github_email: john.doe@email.com

  roles:
    - dev
```

## License

Copyright (C) Daniel Fernandes Martins

Distributed under the New BSD License. See LICENSE for further details.
