# Arch Linux I3 Configuration

This role configures my window manager of choice, i3-gaps.

## Requirements

This role only supports Arch Linux systems with AUR enabled.

## Role Variables

```yaml
# Username of the main user of the system.
user_name:

# Group name of the main user of the system.
user_group:

# Whether to configure LighDM to autologin.
user_autologin: false

# If the system have bluetooth support, enable this to install the required packages.
system_bluetooth: false

# GTK bookmarks to add to file managers. These directories will be created.
gtk_bookmarks:
  - name: Downloads
    path: '/home/{{ user_name }}/Downloads'

# GTK theme.
gtk_theme: Matcha-azul
gtk_icon_theme: Papirus
gtk_cursor_theme: Breeze

# Polybar theme used as starting point.
polybar_base_theme: forest

# UserJS version to download.
# Ref: https://github.com/arkenfox/user.js/releases
userjs_version: 91.1
userjs_checksum: sha256:c622a876bb0fc9069341154319e237edf0808ff5b5fd041cb30f610da1f3f0f4

# Terminal emulator to use in i3 commands.
i3_term: /usr/bin/urxvt

# Extra commands to append to i3 config.
extra_i3_config: ''
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
    - i3
```

## License

Copyright (C) Daniel Fernandes Martins

Distributed under the New BSD License. See LICENSE for further details.
