# backuplift

![](https://pbcdn.cloud/backuplift.png)

Backups are the most important part of securing your website. But many people are having a hard time finding cost - effective ways to back up the website. With the backuplift script, you can set up a backup to be stored on a Hetzner storage box.

- Run backup with cron, 
- Takes 5-minutes to setup everything.
- Get peace of mind knowing your site is backed-up.

------------

# How to use this?

### **STEP 1. Create SSH key for secure comminication.**

I have written down step by step way to create & authenticate your storagebox to your server, [click here to read md file](https://github.com/manoj-wpzonify/backuplift/blob/main/how-to-create-ssh-key.md "click here to read md file").

*Only prorceed to next step if you were able to authenticate properly*

### **STEP 2. download profile.sh file & upload to your server**

- Create folder, name it backuplift.
- Then download the profile.sh & upload to backuplift folder

or you can type the following command to do it. [This will create folder & download the profile.sh file]

`mkdir backuplift && wget https://github.com/manoj-wpzonify/backuplift/blob/main/profile.sh -P backuplift`

**it would be good idea to do this in the `/home` directory. of course you can do it anywhere you want.*

### **STEP 3. Modify profile.sh file with your own storagebox details**

- Open the profile.sh file

`nano profile.sh`

- And modify the following with your storagebox details

> remote_dirs=""  -------------> remote directory location. 
remote_user=""    -------------> hetzner storagebox username
remote_server="" -------------> hetzner storagebox hostname
target_dir=""        -------------> Your website directory path.

- Save the changes & close the editor.

### **STEP 4. Create cronjob that runs as per your preference**

You can find the example cronjob below.

`0 0 * * *  bash /backuplift/profile.sh > /backuplift/profile_log `

This runs midnight, you can customize the way you want.

# That's all, Your backups now will run every day & stored in your hetzner.
