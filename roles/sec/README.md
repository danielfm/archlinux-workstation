# Security Tools

This role configures software related to privacy and security, such as
YubiKey integration, secure boot key generation and image signing, firewall
rules, etc.

## Variables

### `user_name`

**Default value:** `None`

Username of the main user of the system.

### `user_group`

**Default value:** `None`

Group name of the main user of the system.

### `user_gnupg_key_id`

**Default value:** `None`

GPG key id used as the default GPG key for encrypt operations.

### `user_gnupg_keyserver`

**Default value:** `hkp://pool.sks-keyservers.net`

Default GPG Keyserver used to fetch and publish keys.

### `user_pam_u2f_key_handles`

**Default value:** `None`

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

### `system_secure_boot_keys_dir`

**Default value:** `/root/.secure-boot-keys`

Directory in which to generate the keys used to sign and verify system images
at boot time.

If you don't wish to generate such keys, set this variable to `''`.
