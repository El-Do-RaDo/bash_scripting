#!/bin/bash
clear


echo "============================================"
echo "WordPress Install Script"
echo "============================================"
echo "Database Name: "
read dbname
echo "Database User: "
read dbuser
echo "Database Password: "
read -r dbpass

echo "=============Admin details=================="
echo -n "Site url (e.g https://www.xyz.com/) : "
read siteurl
echo -n "Site Name (e.g xyz) : "
read sitename
echo -n "Email Address (e.g abc@xyz.in) : "
read wpemail
echo -n "Admin User Name : "
read wpuser
echo -n "Admin User Password : "
read wppass
echo "run install? (y/n)"
read  run
if [ "$run" = y ] ; then
echo "============================================"
echo "A robot is now installing WordPress for you."
echo "============================================"
#download wordpress
curl -O https://wordpress.org/latest.tar.gz
#unzip wordpress
tar -zxvf latest.tar.gz
#change dir to wordpress
cd wordpress
#copy file to parent dir
cp -rf . ..
#move back to parent dir
cd ..
#remove files from wordpress folder
rm -R wordpress
#create wp config
cp wp-config-sample.php wp-config.php

#set database details with sed find and replace

sed -i "s/database_name_here/$dbname/" wp-config.php
sed -i "s/username_here/$dbuser/" wp-config.php
sed -i "s/password_here/$dbpass/" wp-config.php


#set WP salts
perl -i -pe'
  BEGIN {
    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  }
  s/put your unique phrase here/salt()/ge
' wp-config.php

#create uploads folder and set permissions
mkdir wp-content/uploads
chmod 775 wp-content/uploads
wp core install --allow-root --url="$siteurl" --title="$sitename" --admin_user="$wpuser" --admin_password="$wppass" --admin_email="$wpemail"
echo "Cleaning..."
#remove zip file
rm latest.tar.gz
#remove bash script
rm autowpsetup.sh
echo "========================="
echo "Installation is complete."
echo "========================="
else
exit
fi
