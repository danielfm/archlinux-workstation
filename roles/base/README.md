# Archlinux Base System Configuration

This is the base configuration for setting up the base system.

Some of the features provided by this role:

- Enable `multilib` repository
- Set up `yay` for an easy way of using the AUR
- System-wide DNSSEC and DNS-over-TLS support
- Periodic backup with [Duplicity](http://duplicity.nongnu.org/) and Amazon S3

## Requirements

For the S3-backed backup storage to work, you'll need:

- AWS account and an S3 bucket.
- GnuPG key for encrypting the backup files before uploading them to S3.
- GoPass password store with a directory containing two secrets,
  `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`, with a valid AWS access key,
  and that key must have read/write access to files in the target S3 bucket.

## Role Variables

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

GPG key id used as the default GPG key for encrypt operations.

### `backup_enabled`

**Default value:** `true`

Whether to enable the Duplicity backup service.

### `backup_schedule`

**Default value:** `daily`

Backup schedule.

### `backup_retention_days`

**Default value:** `30`

Maximum days to keep each backup version.

### `backup_full_period_days`

**Default value:** `7`

Force a full backup after that period, and use incremental backups otherwise.

### `backup_s3_bucket_name`

**Default value:** `None`

S3 bucket name in which to upload the backups.

### `backup_s3_gopass_secret_dir`

**Default value:** `None`

Directory in your `gopass` store which contains two secrets, `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.

### `backup_source_dir`

**Default value:** `$HOME`

Main directory to include in the backups.

### `backup_exclude`

**Default value:** `""`

Multi-line string containing file patterns to exclude from the backup.

### `backup_gnupg_signing_key_id`

**Default value:** `None`

GPG key id used to sign Duplicity backups.

### `backup_gnupg_encrypt_key_id`

**Default value:** `None`

GPG key id used to encrypt Duplicity backups.

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

## Dependencies

This role doesn't have any dependencies.
