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

 - Benötigt einen Webserver mit PHP >=5.6, GD und EXIF-Support
 - Benötigt eine MySQL-Datenbank
 - Benötigt [composer](https://getcomposer.org/)
 - tesseract >=3
   - Um OCR für Grafiken auszuführen
   - nicht wirklich getestet, Sprache Deutsch voreingestellt
 - pdftotext
   - Zum Extrahieren von Text aus PDF-Dateien
 - imagemagick
   - bzw. dessen convert um Bilddaten umzuwandeln

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

## Hinweise
 - Aktuell existiert keine grafische Nutzerverwaltung, das Passwort kann also nicht geändert werden. Generell empfieht es sich eine Authentifizierung auf Webserverebene einzurichten. Die Nutzer lassen sich in SQL editieren, passende Passwort-Hashes können üder die Funktion [session_getNewPasswordHash](https://github.com/adlerweb/awtools/blob/master/session.php#L137) generiert werden.
 - Backups.
 - Mehr Backups.
