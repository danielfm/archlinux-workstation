# Base Configuration

This is the base configuration for setting up the base system.

Some of the features provided by this role:

- Enable `multilib` repository
- Set up `yay` for an easy way of using the AUR
- System-wide DNSSEC and DNS-over-TLS support
- Periodic backup with [Duplicity](http://duplicity.nongnu.org/) and Amazon S3

## Variables

### `user_name`

**Default value:** `None`

Username of the main user of the system.

### `user_group`

**Default value:** `None`

Group name of the main user of the system.

### `user_uid`

**Default value:** `None`

UID of the main user of the system.

### `user_gid`

**Default value:** `None`

GID of the main user of the system.

### `user_create_ssh_keypair`

**Default value:** `yes`

Whether to create a SSH keypair for the main user of the system.

### `user_gnupg_key_id`

**Default value:** `None`

GPG key id used as the default GPG key for encryption and signing operations.

### `user_extra_home_dirs`

**Default value:** `[]`

Additional directories to create in the main user's home directory.

### `system_timezone`

**Default value:** `America/Sao_Paulo`

System timezone.

### `system_locale`

**Default value:** `en_US.UTF-8`

System locale.

### `system_bluetooth`

**Default value:** `yes`

If the system have bluetooth support, enable this to install the required packages.

### `system_resolvconf`

**Default value:** [Quad9 DNS servers](https://www.quad9.net/)

```
nameserver 9.9.9.9
nameserver 149.112.112.112
```

DNS servers to be used by the system. The configuration sets up systemd-resolved
to require DNSSEC and DNS-over-TLS for increased security and privacy.

### `system_dns_over_tls`

**Default value:** `yes`

Whether to enforce communication with the DNS servers via TLS.

### `system_dns_dnssec`

**Default value:** `yes`

Whether systemd-resolved must fail to resolve domains without DNSSEC enabled.
Change this to `no` if you are experiencing issues with sites you need to use.

## References

- <https://wiki.archlinux.org/index.php/Bluetooth>
- <https://wiki.archlinux.org/index.php/Systemd-resolved>
