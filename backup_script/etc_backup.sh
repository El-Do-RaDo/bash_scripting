#!/bin/sh

#Here we give the directory name where we want to create our back file so we replace /home/aniket/ with the directory name that we want
#mkdir command will create a directory inside /home/aniket/ with backups for me might vary for you & cd will change directory to the particular location
sudo mkdir -p /home/aniket/backups && cd "/home/aniket/backups/" 
#Here we are creating the back up of /etc directory with all the data lib content of etc and creating a zip file of that directory with particular date on the file name. 
#this command will create a zip file with etc-21-01-18.zip name where the format will be etc-current_date.zip
sudo zip -r "etc-$(date +"%Y-%m-%d").zip" /etc/
