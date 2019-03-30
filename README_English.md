# AdAr - Another dumb Archive

(sorry, ATM german only)

AdAr is a further development based on the system "DiBaS (Digital Image Archive Saffig)", which was developed for the archiving of the photo collection of the history association Saffig. In this project, the system was supplemented by document-relevant functions such as OCR, contact management and others.

AdAr is currently only available in German. The PHP code is provided under the terms of GPLv3 or later. Some libraries, which are in this repo, stand under other licenses, which can be seen in the respective project folder.

Attention: crafted with part historical code. Do not use productively without scrutiny.

If the PHP EXIF ​​extension is installed, it will be used
If pdftotext is installed this is used

## usage
The system is actively used by me for data storage. For this purpose, PDF files are generated with text (see tools /) and then uploaded

## installation

### Requirements

 - Requires a web server with PHP> = 7.0, GD and EXIF ​​support
 - Requires server with IPv4 access (Github does not support IPv6 yet)
 - Requires a MySQL / MariaDB database
 - Requires [composer] (https://getcomposer.org/)
 - tesseract> = 3
   - To execute OCR for graphics
   - not really tested, language German preset
 - pdftotext
   - For extracting text from PDF files
 - imagemagick
   - or its convert to convert image data

### Facility

 - Copy data to web server
   - The folder data / * and tpl / cache / must be writable for the web server
 - Create MySQL database and import doc / mysql.sql
 - Add access data in config.php
   - Optional: Customize installation name (ADAR_PROGNAME)
   - Optional: Add an e-mail address to ADAR_INFOMAIL_TO, in which case an e-mail will be sent to this address every time a new system is created
 - Install dependencies: `` `composer install```
 - cron.php should be called regularly as a web server, otherwise temporary files will not be cleaned up and OCR will not be executed
   - eg `` `* / 15 * * * * / usr / bin / php -f / var / www / cron.php> / var / log / adar.cron.log``` in crontab
 - Login with admin / admin

### Debian Jessie

For Debian Jessie, an automatic installation script with configuration wizard is available in [doc / setup-debian8.sh] (https://github.com/adlerweb/adar/blob/master/doc/setup-debian8.sh):

`` ``
pushd / tmp
wget "https://raw.githubusercontent.com/adlerweb/adar/master/doc/setup-debian8.sh"
bash setup-debian8.de
popd
`` ``

This installs all prerequisites (Apache / MariaDB, etc), changes the configurations, creates the database and sets a login password. Since this system configurations are changed, the script should only be used on systems exclusively intended for AdAr (VM, container, etc).
Attention: The PHP7 installation uses the dotdeb repository, which is currently only available for x86 processors. It is therefore not possible to use automatic installation on ARM systems such as Raspberry Pi.

## Hints
 - Currently there is no graphical user administration, so the password can not be changed. In general, it is advisable to set up authentication at the web server level. The users can be edited in SQL, suitable password hashes can be generated using the function [session_getNewPasswordHash] (https://github.com/adlerweb/awtools/blob/master/session.php#L137).
 - Backups.
 - More backups.