# Arch Linux Package Repositories Configuration

This role enables the usage of the AUR package repository.

Some of the features provided by this role:

- Enable `multilib` repository
- Enable the pacman cache cleaner
- Set up `yay` for an easy way of using the AUR

## Requirements

This role only supports Arch Linux systems.

## Role Variables

```yaml
# UID of the `aur_builder` user.
aur_builder_uid: 1001
```

## Dependencies

Collections:

- `kewlfft.aur`

## Example Playbook

```yaml
---

- name: Converge
  hosts: all
  gather_facts: false
  become: true

  roles:
    - aur
```

## License

Copyright (C) Daniel Fernandes Martins

Distributed under the New BSD License. See LICENSE for further details.
