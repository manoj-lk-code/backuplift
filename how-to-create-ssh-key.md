**[NEW] You can update hetzner storagebox username in authenticator.sh file and run it to do the following without doing it manually.**

Update username and run this command:

`chmod +x backuplift/profile.sh ; ./backuplift/authenticator.sh`

This will create backuplift directory, download the file, make it executable and run the file.

--

**[OLD] You can also do this manually:**

**To generate new ssh key, type the following in your server ssh terminal**

`ssh-keygen`

**The above command will prompt to ask for location. type the following including dot**

`.ssh/id_rsa_backuplift_hetzner_backups`

**Converting your key to RFC4716 format - must for sftp**

`ssh-keygen -e -f .ssh/id_rsa_backuplift_hetzner_backups.pub | grep -v "Comment:" > .ssh/id_rsa_backuplift_hetzner_backups_rfc.pub`

**Creating authorized_keys file**

`cat .ssh/id_rsa_backuplift_hetzner_backups.pub >> .ssh/storagebox_authorized_keys`

**For SFTP - must**

`cat .ssh/id_rsa_backuplift_hetzner_backups_rfc.pub >> .ssh/storagebox_authorized_keys`

**copy storagebox_authorized_keys content to storagebox .ssh/authorized_keys**

`cat .ssh/storagebox_authorized_keys`

Now copy the content displayed, note down somewhere else.

**Create ssh folder in storagebox**

- Create `.ssh` folder in the root directory and create file called `authorized_keys` inside .ssh folder

- Paste the copied content inside authorized_keys with your favorite editor. 

***Thats all, test connection using the following command in your server ssh terminal***

`sftp -i .ssh/id_rsa_backuplift_hetzner_backups username@username.your-storagebox.de`
