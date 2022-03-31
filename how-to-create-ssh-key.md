# Generating new ssh key

ssh-keygen

# The above command will prompt to ask for location. type below by replacing with your location

.ssh/id_rsa_manoj_hetzner_backups

# Converting your key to RFC4716 format - for sftp

ssh-keygen -e -f .ssh/id_rsa_manoj_hetzner_backups.pub | grep -v "Comment:" > .ssh/id_rsa_manoj_hetzner_backups_rfc.pub

# Creating authorized_keys file

cat .ssh/id_rsa_manoj_hetzner_backups.pub >> .ssh/storagebox_authorized_keys

# For SFTP -must

cat .ssh/id_rsa_manoj_hetzner_backups_rfc.pub >> .ssh/storagebox_authorized_keys

# copy storagebox_authorized_keys content to storagebox .ssh/authorized_keys

# thatsall, test connection using the following

sftp -i .ssh/id_rsa_manoj_hetzner_backups u296992@u296992.your-storagebox.de