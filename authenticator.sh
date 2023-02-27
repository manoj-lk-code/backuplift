#!/bin/bash

# Check if id_rsa_backuplift_hetzner_backups exists
if [ -f .ssh/id_rsa_backuplift_hetzner_backups ]; then
  echo "id_rsa_backuplift_hetzner_backups already exists. Aborting..."
  exit 1
fi

# Generate ssh key without asking for passphrase and store it in .ssh/id_rsa_backuplift_hetzner_backups
ssh-keygen -t rsa -b 4096 -N "" -f .ssh/id_rsa_backuplift_hetzner_backups

# Convert key to RFC4716
ssh-keygen -e -f .ssh/id_rsa_backuplift_hetzner_backups.pub | grep -v "Comment:" > .ssh/id_rsa_backuplift_hetzner_backups_rfc.pub

# Append the public keys to storagebox_authorized_keys
cat .ssh/id_rsa_backuplift_hetzner_backups.pub >> .ssh/storagebox_authorized_keys
cat .ssh/id_rsa_backuplift_hetzner_backups_rfc.pub >> .ssh/storagebox_authorized_keys

# Create .ssh directory in the remote server and upload authorized_keys
echo "mkdir .ssh" | sftp username@username.your-storagebox.de
scp .ssh/storagebox_authorized_keys username@username.your-storagebox.de:.ssh/authorized_keys
