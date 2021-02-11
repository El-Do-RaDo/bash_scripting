#!/bin/bash
echo "db.getMongo().getDBNames()"|mongo --quiet |tr -d \[\] | tr , "\n"|cut -c3-| tr -d \" | grep -Ev "(admin|config|local|aapChatApp)" > db.txt

mkdir $HOME/backup/$(date +"%d-%m-%Y")

for db in `cat db.txt`; do
mongodump  --db $db --out $HOME/backup/$(date +"%d-%m-%Y")/
done

zip -r $HOME/backup/$(date +"%d-%m-%Y").zip $HOME/backup/$(date +"%d-%m-%Y")
aws s3 cp $HOME/backup/$(date +"%d-%m-%Y").zip s3://aaochat/db_backup/


rm -rf $HOME/db.txt
rm -rf $HOME/backup/*

