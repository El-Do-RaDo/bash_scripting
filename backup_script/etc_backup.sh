#!/bin/sh

#here we give the directory name where we want to create our back file so we replace /home/aniket/ with the directory name that we want
sudo mkdir /home/aniket/backups && cd "/home/aniket/backups/" 
sudo zip -r "etc-$(date +"%Y-%m-%d").zip" /etc/
