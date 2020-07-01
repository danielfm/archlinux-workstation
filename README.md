# Arch Linux Workstation

[Ansible](https://www.ansible.com/) playbook for configuring my main work
machine on top of a clean [Arch Linux](https://www.archlinux.org/) installation.

This configuration sets up a desktop environment based on
[i3-gaps](https://github.com/Airblader/i3), a popular fork of the
[i3](https://i3wm.org/) tiling window manager.

![screenshot](./screenshot.png)

**Note:** Since this is used in different machines with different hardware, it
does not try to set up hardware-specific drivers and configuration; these should
be done manually in each machine.

**Note:** This setup is constantly evolving, so the screenshot will most likely
be outdated.

## Roles

This installation contains the following roles:

| Role    | Description                                                         |
|---------|---------------------------------------------------------------------|
| `base`  | Sets up the base system configuration                               |
| `i3`    | Sets up i3 window manager desktop environment                       |
| `dev`   | Sets up necessary packages for my current software engineering role |
| `sec`   | Sets up security-related packages and configuration                 |
| `audio` | Sets up the software I use for audio recording, my current hobby :) |

## Instructions

First, follow the
[official installation guide](https://wiki.archlinux.org/index.php/installation_guide)
to bootstrap the bare-bones, bootable system.

I also use
[full disk encryption](https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS)
as I always need to keep some private information stored in the local disk. This
protects my files from being accessed in case my work machine gets stolen.

This configuration generates the required keys for enrolling into the firmware
if the `system_secure_boot: on` variable is set. Follow the
[Arch wiki](https://wiki.archlinux.org/index.php/Secure_Boot) for instructions
on how to proceed.

### Pre-Installation

#### Install the Required Packages

Run the following command as `root` to install the packages required to
complete the rest of the installation:

```sh
pacman -S ansible git git-lfs base-devel sudo nano openssh
```

### Create User

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
in a new file `vars/custom.yml` (see the available vars in `vars/main.yml`) and
then run the following command to apply the Ansible playbook:

```sh
# Clone the repository:
git clone https://github.com/danielfm/archlinux-workstation.git
cd archlinux-workstation

# Change some variables (i.e. the user password hash):
cp vars/main.yml vars/custom.yml
nano vars/custom.yml

# Run the playbook:
ansible-playbook playbook.yml -e "@vars/custom.yml"
```

Don't leave the machine unattended as you'll might have to re-enter the user
password a few times throughout the process when installing the required packages.

#### Troubleshooting: AUR Issues

The AUR is community-maintained, so it's not that uncommon to find outdated
packages that cannot be installed (i.e. due to having mismatching validation
hash).

If you encounter any issues, you'll have to fix the affected packages by hand
before retrying the `ansible-playbook` command.

Some commands that might be useful:

```sh
# If you need to edit the PKGBUILD file to fix a validation SHA or download URL:
yay -S <package> --editmenu
```

### Post-Installation

#### Local 2FA With YubiKey + PAM

This setup supports configuring local 2FA with U2F keys (such as YubiKeys).

Run `pam2fcfg` and press the blinking button on each key in order to output a
string in the following format:

```sh
# Run this command and press the blinking key, if asked:
pamu2fcfg | cut -d ':' -f 2
```

Copy the output for this command, for each key (main and backup), to the
`{{ user_pam_u2f_main_key }}` and `{{ user_pam_u2f_backup_key }}` variables,
respectively.

Then, re-run the playbook to apply the configuration.

**Note:** This setup will only be activated if you provide data for both
security keys, so you have a backup in case you lose your main key.

More information:

- https://infosec-handbook.eu/blog/yubikey-2fa-pam/

#### YubiKey + GnuPG Setup

Some YubiKeys can be used as a GPG smart card, allowing us to store GPG
encryption, signing and authentication keys in it.

More information:

- https://github.com/drduh/YubiKey-Guide
- https://www.esev.com/blog/post/2015-01-pgp-ssh-key-on-yubikey-neo/

### That's It!

If the `ansible-playbook` command finishes successfully, reboot the system to
access your new environment!
