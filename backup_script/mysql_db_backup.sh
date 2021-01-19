#!/bin/bash

#Here we are taking of all the back of databases present in our mysql

#This is the directory where I am create my backup directory
BACKUP_DIR=/home/ubuntu/
mkdir -p $BACKUP_DIR/db_backups/$(date +"%d-%m-%Y")
mysql_user=root
mysql_pass=admin@123
databases=`mysql -u$mysql_user --password=$mysql_pass -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|mysql|performance_schema|sys)"`
for db in $databases; do
echo $db
mysqldump --force --opt --skip-lock-tables --user=$mysql_user --password=$mysql_pass --databases $db | gzip > "$BACKUP_DIR/db_backups/$(date +"%d-%m-%Y")/$db.gz"
done
find $BACKUP_DIR/db_backups/* -mtime +10 -exec rm -rf {} \;
