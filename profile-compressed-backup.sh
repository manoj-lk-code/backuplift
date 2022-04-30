#!/bin/bash


# START EDITING..

remote_dirs="wpzonify" 
remote_user="u296992"
remote_server="u296992.your-storagebox.de"
target_dir="/home/runcloud/webapps/app-wpzonify"

# STOP EDITING..!


date=$(date +"%d-%b-%Y")
ssh_key_loc="/root/.ssh/id_rsa_manoj_hetzner_backups"
random_file_name=$(echo $RANDOM | md5sum | head -c 20; echo;)
wpmysqluser=$(grep -w "DB_NAME" $target_dir/wp-config.php | cut --delimiter="'"  --fields="4")
wpmysqldb=$(grep -w "DB_USER" $target_dir/wp-config.php | cut --delimiter="'"  --fields="4")
wpmysqluserpass=$(grep -w "DB_PASSWORD" $target_dir/wp-config.php | cut --delimiter="'"  --fields="4")

# create backup folder if not exist

echo "Creating backup directory"
mkdir -p $target_dir/wp-backup-profile/$date
echo "Finished creating directory"

#Create database dump file or backup file.

mysqldump --no-tablespaces -u $wpmysqluser -p$wpmysqluserpass $wpmysqldb > $target_dir/wp-backup-profile/$date/database-$date-$random_file_name.sql

#Creating directory zip file with date.

echo "Compressing your directory"
tar -zcvf $target_dir/wp-backup-profile/$date/files-$date-$random_file_name.tar.gz $target_dir 
echo "compressed the directory is finished"

#transferring compressed date directory via rsync

echo
echo "starting rsync backup..."
rsync --progress -auvz -e 'ssh -p23 $ssh_connect' --recursive $target_dir/wp-backup-profile/$date $remote_user@$remote_server:$remote_dirs
echo "done. Finished sending backup date directory to remote location"

#delete backup folder after transfering to remote location.

echo "deleting your backup date folder & sql file"
rm -rf $target_dir/wp-backup-profile
echo "finished deleting the backup"
echo "....................."
echo "....................."
echo "....................."
echo "Backup job finished, isn't it awesome?"
