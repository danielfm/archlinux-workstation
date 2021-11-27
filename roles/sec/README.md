# Security and Privacy Configuration

This role configures software related to privacy and security, such as:

- YubiKey integration
- Secure Boot key generation and kernel image signing hooks
- UFW firewall rules

## Requirements

This role only supports Arch Linux systems with AUR enabled.

## Role Variables

```yaml
# Username of the main user of the system.
user_name:

# Group name of the main user of the system.
user_group:

# GPG key id used as the default GPG key for encrypt operations.
user_gnupg_key_id:

# GnuPG keyserver address.
user_gnupg_keyserver: hkp://pool.sks-keyservers.net

# 2FA support with a U2F security key (i.e. YubiKey)
# Format: ':<key-handle>,<public-key>:<key-handle-2>,<public-key-2>:...'
user_pam_u2f_key_handles: ''

# Location to store the generate secure boot keys.
system_secure_boot_keys_dir: /root/.secure-boot-keys
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
    user_group: danielfm
    user_gnupg_key_id: '0x12345678'

  roles:
    - sec
```

## License

Copyright (C) Daniel Fernandes Martins

Distributed under the New BSD License. See LICENSE for further details.
