#!/bin/bash

#Voraussetzungen aus Paketquellen Installieren
apt-get update
apt-get install mariadb-server mariadb-client apache2 imagemagick tesseract-ocr tesseract-ocr-deu poppler-utils git apt-transport-https wget
# "root"-Passwort für MySQL/MariaDB setzen (und merken)

#PHP7
apt-get update
apt-get install php7.2 php7.2-cli php7.2-mysql php7.2-gd libapache2-mod-php7.2 php7.2-opcache php7.2-zip

#PHP konfigurieren
phpenmod gd
phpenmod mysqli
phpenmod opcache
phpenmod zip
sed -e "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php/7.2/apache2/php.ini > /etc/php/7.2/apache2/php.ini.tmp && mv /etc/php/7.2/apache2/php.ini.tmp /etc/php/7.2/apache2/php.ini
sed -e "s/memory_limit = 128M/memory_limit = 512M/g" /etc/php/7.2/cli/php.ini > /etc/php/7.2/cli/php.ini.tmp && mv /etc/php/7.2/cli/php.ini.tmp /etc/php/7.2/cli/php.ini
systemctl restart apache2.service

#Composer ist bisher nur in Testing vorhanden, daher installieren wir nun manuell
pushd /tmp
wget -O - "https://gist.githubusercontent.com/adlerweb/b63784bd859e63ac0bbd8ea85ec161da/raw/54ae771120880364df75141f9d5c39bd82439a4c/composersetup.sh" | sh
mv composer.phar /usr/local/bin/composer
popd

#AdAr Herunterladen
install -o www-data -d /var/www/html/adar/
pushd /var/www/html/adar
su -s $SHELL -c 'git clone https://github.com/adlerweb/adar.git .' www-data

#Abhängigkeiten installieren
install -o www-data -d /var/www/.composer/
su -s $SHELL -c 'composer install' www-data

#MySQL/MariaDB einrichten
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

#Konfiguration anpassen
sed -e "s/testinstallation/$sqlpw/g" config.php > config.php.tmp && mv config.php.tmp config.php

read -p "Absendeadresse für E-Mails? [ADAR <adar@localhost>] " cfgtmp
echo
if [[ -z "${cfgtmp// }" ]] ;then
	cfgtmp="ADAR <adar@localhost>"
fi
sed -e "s/ADAR <adar@localhost>/$cfgtmp/g" config.php > config.php.tmp && mv config.php.tmp config.php

read -p "E-Mail für Benachrichtigung bei Neuanlagen? (Leer = Keine Infomail) " cfgtmp
echo
if [[ ! -z "${cfgtmp// }" ]] ;then
	sed -e "s/''/'$cfgtmp'/g" config.php > config.php.tmp && mv config.php.tmp config.php
fi

unset cfgtmp

# Admin-Passwort festlegen
read -s -p "Passwort für admin? " cfgtmp
echo

cfgtmp=$(echo "<?php require('vendor/adlerweb/awtools/session.php'); \$sess = new adlerweb_session; echo \$sess->session_getNewPasswordHash("$cfgtmp"); ?>" | php 2>/dev/null)

if [[ ! -z "${cfgtmp// }" ]] ;then
	echo "UPDATE Users SET Password = '$cfgtmp' WHERE Nickname = 'admin' LIMIT 1;" | mysql -uadar -p"$sqlpw" adar
else
	echo "Fehler - Passwort wurde nicht geändert, login mit admin:admin"
fi

unset sqlpw
unset cfgtmp

#Cronjob einrichten
echo '*/5 * * * * /usr/bin/php -f /var/www/html/adar/cron.php > /var/log/adar.cron.log' > /etc/cron.d/adar

#Done
popd
echo Setup abgeschlossen
