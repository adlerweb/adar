# AdAr - Another dumb Archive

(sorry, ATM german only)

AdAr ist eine Weiterentwicklung auf Basis des Systems "DiBaS (Digitales Bildarchiv Saffig)", welches zur Archivierung des Fotos-Bestandes des Geschichtsvereins Saffig entwickelt wurde. In diesem Projekt wurde das System um dokumentenrelevante Funktionen wie OCR, Kontaktverwaltung u.A. ergaenzt.

AdAr ist vorerst nur in Deutsch verfuegbar. Der PHP-Code wird unter den Bedingungen der GPLv3 oder neuer bereitgestellt. Einige Libraries, welche sich in diesem Repo befinden, stehen unter anderen Lizenzen, welche im jeweiligen Projektordner eingesehen werden koennen.

Achtung: Gebastel mit Teils historischem Code. Nicht ohne prüfenden Blick produktiv verwenden.

Wenn die PHP-EXIF-Erweiterung installiert ist wird diese verwendet
Wenn pdftotext installiert ist wird dies verwendet

## Nutzung
Das System wird von mir aktiv zur Datenablage genutzt. Hierzu werden PDF-Dateien mit Text generiert (siehe tools/) und im Anschluss hochgeladen

## Installation

### Voraussetzungen

 - Benötigt einen Webserver mit PHP >=7.0, GD und EXIF-Support
 - Benötigt Server mit IPv4-Zugang (Github unterstützt noch kein IPv6)
 - Benötigt eine MySQL/MariaDB-Datenbank
 - Benötigt [composer](https://getcomposer.org/)
 - tesseract >=3
   - Um OCR für Grafiken auszuführen
   - nicht wirklich getestet, Sprache Deutsch voreingestellt
 - pdftotext
   - Zum Extrahieren von Text aus PDF-Dateien
 - imagemagick
   - bzw. dessen convert um Bilddaten umzuwandeln

### Einrichtung

 - Daten auf Webserver kopieren
   - Die Ordner daten/* und tpl/cache/ müssen für den Webserver schreibbar sein
 - MySQL-Datenbank anlegen und doc/mysql.sql importieren
 - Zugangsdaten in config.php ergänzen
   - Optional: Name der Installation (ADAR_PROGNAME) anpassen
   - Optional: E-Mail-Adresse in ADAR_INFOMAIL_TO ergänzen, in diesem Fall wird bei jeder Neuanlage eine E-Mail an diese Adresse versendet
 - Abhängigkeiten installieren: ```composer install```
 - cron.php sollte regelmäßig als Webserver aufgerufen werden, andernfalls werden temporäre Dateien nicht aufgeräumt und OCR nicht ausgeführt
   - z.B. ```*/15 * * * * /usr/bin/php -f /var/www/cron.php > /var/log/adar.cron.log``` in crontab
 - Login mit admin/admin

### Debian Jessie

Für Debian Jessie steht ein automatisches Installationsscript mit Konfigurationsassistent in [doc/setup-debian8.sh](https://github.com/adlerweb/adar/blob/master/doc/setup-debian8.sh) zur Verfügung:

````
pushd /tmp
wget "https://raw.githubusercontent.com/adlerweb/adar/master/doc/setup-debian8.sh"
bash setup-debian8.de
popd
````

Dies installiert alle Voraussetzungen (Apache/MariaDB, etc), ändert die Konfigurationen, erstellt die Datenbank und legt ein Login-Passwort fest. Da hierbei Systemkonfigurationen geändert werden sollte das Script nur auf ausschließlich für AdAr vorgesehenen Systemen (VM, Container, etc) verwendet werden.
Achtung: Für die PHP7-Installation wird das dotdeb-Repository verwendet, dies ist aktuell nur für x86-Prozessoren verfügbar. Eine Nutzung der automatischen Installation auf ARM-Systemen wie Raspberry Pi ist daher nicht möglich.

## Hinweise
 - Aktuell existiert keine grafische Nutzerverwaltung, das Passwort kann also nicht geändert werden. Generell empfieht es sich eine Authentifizierung auf Webserverebene einzurichten. Die Nutzer lassen sich in SQL editieren, passende Passwort-Hashes können üder die Funktion [session_getNewPasswordHash](https://github.com/adlerweb/awtools/blob/master/session.php#L137) generiert werden.
 - Backups.
 - Mehr Backups.
