#!/bin/bash

#pull filesystem + mysql db backups

remote_dirs="" #remote ftp/ftp dir to backup
remote_user="" #remote  ftp username
remote_server="" #remote ftp hostname
ssh_options="-i /root/.ssh/id_rsa" #sshkey location
target_dir="" #backup directory location that you'd like to backup
backup_target="" #backup where to
date=$(date +"%d-%b-%Y")
wpdomain="domain" #wp domain name without any space
wpmysqluser="" #wordpress database username
wpmysqldb="" #wordpress database
wpmysqluserpass="" #wordpress database user password

# create backup folder if not exist

echo "Creating backup date directory"
mkdir -p /$backup_target/$wpdomain/$date
echo "Finished creating date directory"

#Create database dump file or backup file.

mysqldump --no-tablespaces -u $wpmysqluser -p$wpmysqluserpass $wpmysqldb > $backup_target/$date/$date.sql

#Creating directory zip file with date.

echo "Compressing your directory"
zip -r $backup_target/$date/$date.zip $target_dir
echo "compressed the directory is finished"

#transferring compressed date directory via rsync

echo
echo "starting rsync backup..."
rsync --progress -e 'ssh -p23' --recursive $backup_target/$date $remote_user@$remote_server:$remote_dirs
echo "done. Finished sending backup date directory to remote location"

#delete backup folder after transfering to remote location.

echo "deleting your backup date folder & sql file"
rm -r $backup_target/$date
echo "finished deleting the backup"

