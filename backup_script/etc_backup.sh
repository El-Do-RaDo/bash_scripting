#!/bin/sh

sudo mkdir /home/aniket/Music/backups && cd "/home/aniket/Music/backups/"
sudo zip -r "etc-$(date +"%Y-%m-%d").zip" /etc/
