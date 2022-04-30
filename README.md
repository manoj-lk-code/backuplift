# backuplift

![](https://pbcdn.cloud/backuplift.png)

Backups are the most important part of securing your website. But many people are having a hard time finding cost - effective ways to back up the website. With the backuplift script, you can set up a backup to be stored on a Hetzner storage box.

- Run backup with cron, 
- Takes 5-minutes to setup everything.
- Get peace of mind knowing your site is backed-up.

------------

# How to use this?

#### **STEP 1. Create SSH key for secure comminication.**

I have written down step by step way to create & authenticate your storagebox to your server, [click here to read md file](https://github.com/manoj-wpzonify/backuplift/blob/main/how-to-create-ssh-key.md "click here to read md file").

#### **STEP 2. Dowbload profile.sh file & upload to your server**

- Create folder, name it backuplift.
- Then download the profile.sh & upload to backuplift folder

or you can type the following command to do it. [This will create folder & download the profile.sh file]

`mkdir backuplift ; wget https://github.com/manoj-wpzonify/backuplift/blob/main/profile.sh -P backuplift`

*it would be good idea to do this in the `/home` directory. of course you can do it anywhere you want.

