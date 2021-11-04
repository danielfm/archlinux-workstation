# Arch Linux Workstation

[Ansible](https://www.ansible.com/) playbook for configuring my main work
machine on top of a clean [Arch Linux](https://www.archlinux.org/) installation.

This configuration sets up a desktop environment based on
[i3-gaps](https://github.com/Airblader/i3), a popular fork of the
[i3](https://i3wm.org/) tiling window manager.

![screenshot](./screenshot.png)

**Note:** Since this is used in different machines with different hardware, it
does not try to set up hardware-specific drivers and configuration (i.e.
graphics card); these should be done manually in each machine.

**Note:** This setup is constantly evolving, so the screenshot will most likely
be outdated.

## Ansible Roles

This installation contains the following Ansible roles:

| Role     | Description                                                          |
|----------|----------------------------------------------------------------------|
| `base`   | Sets up the base system configuration                                |
| `i3`     | Sets up i3 window manager desktop environment                        |
| `dev`    | Sets up necessary packages for my current job as a software engineer |
| `sec`    | Sets up security-related packages and configuration                  |
| `studio` | Sets up the software I use for audio/video recording and processing  |

## Instructions

First, follow the
[official installation guide](https://wiki.archlinux.org/index.php/installation_guide)
to bootstrap the bare-bones, bootable system.

I also use
[full disk encryption](https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS)
as I always need to keep some private information stored in the local disk. This
protects my files from being accessed in case my work machine gets stolen.

### Running the Linter

Run `make lint` to run the Ansible linter to detect common issues with the
configuration.

### Provisioning a VM with Vagrant

To bootstrap a VM with this configuration, make sure you have
[Vagrant](https://www.vagrantup.com/) installed and then run
`make vagrant`.

Check the troubleshooting section below if you find any errors
when applying the configuration.

### Pre-Installation

#### Install the Required Packages

Install the required Ansible roles:

```sh
ansible-galaxy install -r requirements.yml
```

Run the following command as `root` to install the packages required to
complete the rest of the installation:

```sh
pacman -S ansible git git-lfs base-devel sudo nano openssh
```

#### Create User

Run the following commands as root to create a new user:

```sh
# Create a group and user (replace <user>/<group> by the desired values):
groupadd <user>
useradd -m -g <group> -G wheel <user>
passwd <user>

# Make sure the  user is allowed to sudo:
EDITOR=nano visudo -f /etc/sudoers.d/<user>
```

### Running the Ansible Playbook

Clone this playbook in your home directory, override the desired variables
in a new file `vars/custom.yml` (see the available vars in `vars/main.yml`)
and then run the following command to apply the Ansible playbook:

```sh
# Clone the repository:
git clone https://github.com/danielfm/archlinux-workstation.git
cd archlinux-workstation

# Edit some variables
nano vars/custom.yml

# Run the playbook:
make run
```

Don't leave the machine unattended as you'll might have to re-enter the user
password a few times throughout the process when installing the required packages.

### Troubleshooting

#### Issues When Applying `ufw` Rules

If you get errors like the following while trying to apply the `ufw`
configuration:

```
fatal: [default]: FAILED! => {"changed": false, "commands": ["/usr/bin/ufw status verbose"], "msg": "ERROR: problem running iptables: iptables v1.8.7 (legacy): can't initialize iptables table `filter': Table does not exist (do you need to insmod?)\nPerhaps iptables or your kernel needs to be upgraded.\n\n\n"}
```

- If you are provisioning a VM with Vagrant, try running `make vagrant` to reboot
  the VM and retry the provisioning.
- If you are provisioning in your machine, try rebooting and retrying.

#### Issues When Installing AUR Packages

The AUR is community-maintained, so it's not that uncommon to find outdated
packages or packages that cannot be installed without manual intervention
(i.e. due to having mismatching validation hash).

If you encounter any issues, you might have to remove the affected packages from
the configuration or fix the affected packages by hand before retrying the
Ansible playbook again.

If you are provisioning a VM with Vagrant, run `vagrant ssh` to log into the
VM and try to fix the situation.

Some commands that might be useful:

```sh
# If you need to edit the PKGBUILD file to fix a validation SHA or download URL:
yay -S <package> --editmenu
```

The installation of AUR packages might also fail when packages try to check
PGP-signed packages when you don't have the corresponding public keys in your
keyring.

You might have better luck in this regard if you use Ubuntu keyserver:

```yaml
# In your vars/custom.yml file:
user_gnupg_keyserver: hkps://keyserver.ubuntu.com
```

Check the comments for the package in the AUR website to see what do to.

### Post-Installation

#### Set User Password

This playbook does not try to force a specific password for your user, so
don't forget to run `sudo passwd {{ user_name }}` to change the password.

#### Secure Boot Configuration

This configuration generates the required keys for enrolling into the firmware
if the `system_secure_boot: on` variable is set. Follow the
[Arch wiki](https://wiki.archlinux.org/index.php/Secure_Boot) for instructions
on how to proceed if you wish to enable secure boot.

#### Local Auth With YubiKey + PAM

This setup allows you to configure PAM to enhance the local security and convenience
via the use of U2F keys, such as YubiKeys:

- Requiring a U2F key to system login (2FA)
- Allowing U2F key to authenticate `sudo` commands instead of typing a
  password

To proceed with this configuration, run `pam2fcfg -n` and press the blinking
button on each key:

```sh
# Run this command and press the blinking key, if asked:
pamu2fcfg -n

# Sample output:
:<key-handle>,<public-key>
```

Run this command for each key you want to register and concatenate the output
for all commands into the `{{ user_pam_u2f_key_handles }}` variable:

```yaml
user_pam_u2f_key_handles: |
  :<key-handle>,<public-key>:<key-handle-2>,<public-key-2>:...
```

Then, re-run the playbook to apply the configuration.

**Note:** Make sure to enable more than one key, so you have a way to log back
in with a backup key in case you lose your main key.

#### YubiKey + GnuPG Setup

Some YubiKeys can be used as a GPG smart card, allowing us to store GPG
encryption, signing and authentication keys in it.

More information:

- https://github.com/drduh/YubiKey-Guide
- https://www.esev.com/blog/post/2015-01-pgp-ssh-key-on-yubikey-neo/

### That's It!

If the `ansible-playbook` command finishes successfully, reboot the system to
access your new environment!

## License

Copyright (C) Daniel Fernandes Martins

Distributed under the New BSD License. See LICENSE for further details.
