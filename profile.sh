#!/bin/bash


# START EDITING..

remote_dirs="" 
remote_user=""
remote_server=""
target_dir=""

# STOP EDITING..!


date=$(date +"%d-%b-%Y")
ssh_key_loc="/root/.ssh/id_rsa_wp_backup_profile_hetzner_backups"
random_db_file_name=$(echo $RANDOM | md5sum | head -c 20; echo;)
wpmysqluser=$(grep -w "DB_NAME" $target_dir/wp-config.php | cut --delimiter="'"  --fields="4")
wpmysqldb=$(grep -w "DB_USER" $target_dir/wp-config.php | cut --delimiter="'"  --fields="4")
wpmysqluserpass=$(grep -w "DB_PASSWORD" $target_dir/wp-config.php | cut --delimiter="'"  --fields="4")


# create backup folder if not exist

echo "Creating backup directory"
mkdir -p $target_dir/wp-database
echo "Finished creating directory"


#Create database dump file or backup file.
echo "....................."
echo "....................."
echo "Exporting sql file..."
echo "....................."
echo "....................."
mysqldump --no-tablespaces -u $wpmysqluser -p$wpmysqluserpass $wpmysqldb > $target_dir/wp-database/$date-$random_db_file_name.sql
echo "done.!"
echo "....................."
echo "....................."
echo "This SQL file will be sent to remote location via rsync"

#transferring compressed date directory via rsync

echo "....................."
echo "....................."
echo "starting rsync backup"
echo "This process will take time depending on size of your website..."
rsync --progress -auvz -e "ssh -p23 -i $ssh_key_loc" --recursive $target_dir $remote_user@$remote_server:$remote_dirs/$date
echo "done.!"
echo "....................."
echo "....................."
echo "Finished sending backup date directory to remote location"


#delete backup folder after transfering to remote location.

echo "deleting your SQL file to avoid impacting disk space usage"
echo "....................."
echo "....................."
rm -rf $target_dir/wp-database
echo "done.!"
echo "....................."
echo "....................."
echo "finished backups. "

