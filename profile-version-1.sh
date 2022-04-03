#!/bin/bash




# START EDITING..

remote_dirs="" #remote dirs to backup
remote_user=""
remote_server=""
ssh_key_loc="/root/.ssh/id_rsa"
target_dir=""
date=$(date +"%d-%b-%Y")
wpmysqluser=""
wpmysqldb=""
wpmysqluserpass=""

# STOP EDITING..!










#Create database dump file or backup file.
echo "....................."
echo "....................."
echo "Exporting sql file..."
echo "....................."
echo "....................."
mysqldump --no-tablespaces -u $wpmysqluser -p$wpmysqluserpass $wpmysqldb > $target_dir/$date.sql
echo "done.!"
echo "....................."
echo "....................."
echo "This SQL file will be sent to remote location via rsync"

#transferring compressed date directory via rsync

echo "....................."
echo "....................."
echo "starting rsync backup..."
rsync --progress -auvz -e "ssh -p23 -i $ssh_key_loc" --recursive $target_dir $remote_user@$remote_server:$remote_dirs/$date > /wp-backups-profile/$date.txt
echo "done.!"
echo "....................."
echo "....................."
echo "Finished sending backup date directory to remote location"


#delete backup folder after transfering to remote location.

echo "deleting your SQL file to avoid impacting disk space usage"
echo "....................."
echo "....................."
rm $target_dir/$date.sql
echo "done.!"
echo "....................."
echo "....................."
echo "finished backups. "

