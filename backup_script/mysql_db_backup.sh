#!/bin/bash

#Here we are taking of all the back of databases present in our mysql

#This is the directory where I am create my backup directory
BACKUP_DIR=/home/ubuntu/

#creating the directory with date 
mkdir -p $BACKUP_DIR/db_backups/$(date +"%d-%m-%Y")

#setting up username and password for mysql you can replace with yours
mysql_user=root
mysql_pass=admin@123

#getting all the databses from the mysql and removing all the system databases
databases=`mysql -u$mysql_user --password=$mysql_pass -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|mysql|performance_schema|sys)"`

#taking backup for all the databases
for db in $databases; do
echo $db
mysqldump --force --opt --skip-lock-tables --user=$mysql_user --password=$mysql_pass --databases $db | gzip > "$BACKUP_DIR/db_backups/$(date +"%d-%m-%Y")/$db.gz"
done

#deleting backup files that are older then 15 days
find $BACKUP_DIR/db_backups/* -mtime +15 -exec rm -rf {} \;
