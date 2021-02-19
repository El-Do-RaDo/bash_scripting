#!/bin/bash
echo "db.getMongo().getDBNames()"|mongo --quiet |tr -d \[\] | tr , "\n"|cut -c3-| tr -d \" | grep -Ev "(admin|config|local)" > db.txt

mkdir $HOME/backup/$(date +"%d-%m-%Y")

for db in `cat db.txt`; do
mongodump  --db $db --out $HOME/backup/$(date +"%d-%m-%Y")/
done


#this part of the script is to upload ur backup to S3 bucket but you can avoid it and replace it with you appropiate
zip -r $HOME/backup/$(date +"%d-%m-%Y").zip $HOME/backup/$(date +"%d-%m-%Y")
aws s3 cp $HOME/backup/$(date +"%d-%m-%Y").zip s3://<bucket_name>/db_backup/

#this  will remove all other things from the local system
rm -rf $HOME/db.txt
rm -rf $HOME/backup/*

