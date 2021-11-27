# Arch Linux Recording Studio Setup

This role installs software needed to record audio in Arch Linux.

References:

- <https://wiki.archlinux.org/index.php/Professional_audio>

## Requirements

This role only supports Arch Linux systems with AUR enabled.

## Role Variables

```yaml
# Username of the main user of the system.
user_name:
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
    user_name: danielfm

  roles:
    - backup
```

## License

Copyright (C) Daniel Fernandes Martins

Distributed under the New BSD License. See LICENSE for further details.
