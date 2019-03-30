#!/bin/bash

#Prerequisites from Package Sources Install
apt-get update
apt-get install mariadb-server mariadb-client apache2 imagemagick tesseract-ocr tesseract-ocr-deu poppler-utils git apt-transport-https
# "root"-Set password for MySQL / MariaDB (and remember)

#PHP7
echo 'deb http://packages.dotdeb.org jessie all' > /etc/apt/sources.list.d/dotdeb.list
curl http://www.dotdeb.org/dotdeb.gpg | apt-key add -
apt-get update
apt-get install php7.0 php7.0-cli php7.0-mysql php7.0-gd libapache2-mod-php7.0 php7.0-opcache php7.0-zip

#PHP configuration
phpenmod gd
phpenmod mysqli
phpenmod opcache
phpenmod zip
sed -e "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php/7.0/apache2/php.ini > /etc/php/7.0/apache2/php.ini.tmp && mv /etc/php/7.0/apache2/php.ini.tmp /etc/php/7.0/apache2/php.ini
sed -e "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php/7.0/cli/php.ini > /etc/php/7.0/cli/php.ini.tmp && mv /etc/php/7.0/cli/php.ini.tmp /etc/php/7.0/cli/php.ini
systemctl restart apache2.service

#Composer is only available in testing, so we install manually now
pushd /tmp
wget -O - "https://gist.githubusercontent.com/adlerweb/b63784bd859e63ac0bbd8ea85ec161da/raw/54ae771120880364df75141f9d5c39bd82439a4c/composersetup.sh" | sh
mv composer.phar /usr/local/bin/composer
popd

#AdAr download
install -o www-data -d /var/www/html/adar/
pushd /var/www/html/adar
su -s $SHELL -c 'git clone https://github.com/adlerweb/adar.git .' www-data

#Dependencies install
install -o www-data -d /var/www/.composer/
su -s $SHELL -c 'composer install' www-data

#MySQL/MariaDB set up
read -s -p "Database root password? " sqlroot
echo
sqlpw=$(base64 /dev/urandom | tr -d '/+' | dd bs=32 count=1 2>/dev/null)

sql="CREATE USER 'adar'@'localhost' IDENTIFIED BY '$sqlpw'; "
sql+="CREATE DATABASE adar; "
sql+="GRANT ALL PRIVILEGES ON \`adar\`.* TO 'adar'@'localhost'; "
sql+="FLUSH PRIVILEGES; "
sql+="USE adar; "
sql+=$(cat doc/mysql.sql)
echo "$sql" | mysql -uroot -p"$sqlroot"
unset sqlroot
unset sql

#configuration to adjust
sed -e "s/testinstallation/$sqlpw/g" config.php > config.php.tmp && mv config.php.tmp config.php

read -p "Sender address for e-mails? [ADAR <doriva17@gmail.com>] " cfgtmp
echo
if [[ -z "${cfgtmp// }" ]] ;then
	cfgtmp="ADAR <adar@localhost>"
fi
sed -e "s/ADAR <adar@localhost>/$cfgtmp/g" config.php > config.php.tmp && mv config.php.tmp config.php

read -p "E-mail for notification of new installations? (Blank = No info mail) " cfgtmp
echo
if [[ ! -z "${cfgtmp// }" ]] ;then
	sed -e "s/''/'$cfgtmp'/g" config.php > config.php.tmp && mv config.php.tmp config.php
fi

unset cfgtmp

# Set admin password
read -s -p "Password for admin? " cfgtmp
echo

cfgtmp=$(echo "<?php require('vendor/adlerweb/awtools/session.php'); \$sess = new adlerweb_session; echo \$sess->session_getNewPasswordHash("$cfgtmp"); ?>" | php 2>/dev/null)

if [[ ! -z "${cfgtmp// }" ]] ;then
	echo "UPDATE Users SET Password = '$cfgtmp' WHERE Nickname = 'admin' LIMIT 1;" | mysql -uadar -p"$sqlpw" adar
else
	echo "Error - password was not changed, login with admin: admin"
fi

unset sqlpw
unset cfgtmp

#Cronjob set up C:\xampp\htdocs\DMS
echo '*/5 * * * * /usr/bin/php -f /C/xampp/htdocs/DMS/cron.php > /var/log/adar.cron.log' > /etc/cron.d/adar

#Done
popd
echo Setup completed
