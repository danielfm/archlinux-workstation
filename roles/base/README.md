# Arch Linux Base System Configuration

This is the base configuration for setting up a base Arch Linux system.

Some of the features provided by this role:

- General system configuration, such as timezone and locale
- System-wide DNSSEC and DNS-over-TLS support
- Grub setup for booting from dmcrypt-encrypted volume
- Support for custom kernel parameters
- Allow the installation of extra packages
- Auto-generation of a SSH key for the main user
- Creation of custom directories in user `$HOME`
- Installation of extra aspell dictionaries (e.g. for emacs users)

## Requirements

This role only supports Arch Linux systems with:

- AUR enabled
- GRUB bootloader

## Role Variables

```yaml
# Username of the main user of the system.
user_name:

# Group name of the main user of the system.
user_group:

# UID of the main user of the system.
user_uid: 1000

# GID of the main user of the system.
user_gid: 1000

# Whether to create a SSH keypair for the main user of the system.
user_create_ssh_keypair: true

# Additional directories to create in the main user's home directory.
user_extra_home_dirs: []

# System timezone.
system_timezone: UTC

# System locale.
system_locale: en_US.UTF-8

# If the system have bluetooth support, enable this to install the required packages.
system_bluetooth: false

# DNS servers to be used by the system.
system_dns_main: 9.9.9.9 149.112.112.112
system_dns_fallback: 1.1.1.1 1.0.0.1

# Whether to enforce communication with the DNS servers via TLS.
system_dns_over_tls: true

# Whether systemd-resolved must fail to resolve domains without DNSSEC enabled.
system_dns_dnssec: true

# Whether to enable optimizations for SSD-based systems.
system_has_ssd: true

# Whetner the disk has full disk encryption with dmcrypt in place.
system_dmcrypt_enabled: true
system_dmcrypt_cryptdevice: ''
system_dmcrypt_cryptkey: ''
system_dmcrypt_root: ''
system_dmcrypt_resume: ''

# Grub options.
system_grub_default: Advanced options for Arch Linux>Arch Linux, with Linux linux-lts
system_grub_timeout_secs: 5

# Extra arguments to pass to the kernel line in the bootloader.
system_kernel_extra_args: ''

# Extra kernel variants to install.
system_extra_kernel_variants: []

# Extra aspell dictionaries to install.
aspell_extra_dictionaries: ['pt']

# Extra packages to install.
extra_packages_pacman: []
extra_packages_aur: []

# Extra systemd services to enable.
extra_enabled_user_services: []
extra_enabled_system_services: []
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

  roles:
    - base
```

## License

Copyright (C) Daniel Fernandes Martins

Distributed under the New BSD License. See LICENSE for further details.
