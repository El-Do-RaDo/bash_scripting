#!/bin/sh

#Here we give the directory name where we want to create our back file so we replace /home/aniket/ with the directory name that we want
sudo mkdir /home/aniket/backups && cd "/home/aniket/backups/" 
#Here we are creating the back up of /etc directory with all the data lib content of etc and creating a zip file of that directory with particular date on the file name. 
sudo zip -r "etc-$(date +"%Y-%m-%d").zip" /etc/
