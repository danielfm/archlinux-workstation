# Archlinux Backup Setup

This role implements a simple backup strategy on top of
[Duplicity](http://duplicity.nongnu.org/) and Amazon S3.

## Requirements

This role only supports Arch Linux systems, as well as:

- An AWS account + S3 bucket.
- GnuPG keys for encrypting the backup files before uploading them to S3.
- A `gopass` password store with a directory containing two secrets,
  `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`, with a valid AWS access key,
  and that key must have read/write access to files in the target S3 bucket.

## Role Variables

```yaml
# Username of the main user of the system.
user_name:

# Group name of the main user of the system.
user_group:

# Whether to enable the Duplicity backup service.
backup_enabled: true

# Systemd schedule for the backup jobs.
backup_schedule: daily

# Accuracy for the Systemd timer.
backup_accuracy: 24h

# Maximum days to keep each backup version.
backup_retention_days: 30

# Force a full backup after that period, and use incremental backups otherwise.
backup_full_period_days: 7

# S3 bucket name in which to upload the backups.
backup_s3_bucket_name:

# Directory in your `gopass` password store which contains two secrets,
# `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.
backup_s3_gopass_secret_dir:

# Main directory to include in the backups.
backup_source_dir: $HOME

# Multi-line string containing file patterns to exclude from the backup.
backup_exclude: ''

# Temp directory used by Duplicity. Automatically excluded from the backup.
backup_temp_dir: '/home/{{ user_name }}/.duplicity-tmp'

# GPG key id used to encrypt and sign the Duplicity backups. Will try to
# auto-detect these keys if not provided.
backup_gnupg_signing_key_id:
backup_gnupg_encrypt_key_id:
```

## Dependencies

None.

## Example Playbook

```yaml
---

- hosts: all
  gather_facts: false
  become: true

  vars:
    user_name: danielfm
    user_group: danielfm

    # Backup
    backup_s3_bucket_name: danielfm-backups

  roles:
    - backup
```

## License

Copyright (C) Daniel Fernandes Martins

Distributed under the New BSD License. See LICENSE for further details.
