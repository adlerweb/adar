-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Erstellungszeit: 18. Mrz 2017 um 13:02
-- Server-Version: 10.1.21-MariaDB
-- PHP-Version: 7.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Datenbank: `adar`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Contacts`
--

CREATE TABLE `Contacts` (
  `CID` int(11) NOT NULL,
  `FamilyName` varchar(164) NOT NULL,
  `GivenName` varchar(224) NOT NULL,
  `Type` set('m','f','u','c') NOT NULL COMMENT '(m)ale, (f)emale, (u)ndefined, (c)ompany',
  `Street` varchar(164) NOT NULL,
  `Housenr` varchar(16) NOT NULL,
  `ZIP` varchar(16) NOT NULL,
  `City` varchar(164) NOT NULL,
  `Country` varchar(2) NOT NULL,
  `Phone` varchar(64) NOT NULL,
  `Fax` varchar(64) NOT NULL,
  `Mail` varchar(164) NOT NULL,
  `URL` varchar(150) NOT NULL,
  `Notes` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Countries`
--

CREATE TABLE `Countries` (
  `Alpha2` varchar(2) NOT NULL,
  `Name` varchar(128) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Source: http://www.iso.org/iso/country_codes/iso_3166_code_l';

--
-- Daten für Tabelle `Countries`
--

INSERT INTO `Countries` (`Alpha2`, `Name`) VALUES
('AF', 'AFGHANISTAN'),
('AX', 'ÅLAND ISLANDS'),
('AL', 'ALBANIA'),
('DZ', 'ALGERIA'),
('AS', 'AMERICAN SAMOA'),
('AD', 'ANDORRA'),
('AO', 'ANGOLA'),
('AI', 'ANGUILLA'),
('AQ', 'ANTARCTICA'),
('AG', 'ANTIGUA AND BARBUDA'),
('AR', 'ARGENTINA'),
('AM', 'ARMENIA'),
('AW', 'ARUBA'),
('AU', 'AUSTRALIA'),
('AT', 'AUSTRIA'),
('AZ', 'AZERBAIJAN'),
('BS', 'BAHAMAS'),
('BH', 'BAHRAIN'),
('BD', 'BANGLADESH'),
('BB', 'BARBADOS'),
('BY', 'BELARUS'),
('BE', 'BELGIUM'),
('BZ', 'BELIZE'),
('BJ', 'BENIN'),
('BM', 'BERMUDA'),
('BT', 'BHUTAN'),
('BO', 'BOLIVIA, PLURINATIONAL STATE OF'),
('BQ', 'BONAIRE, SINT EUSTATIUS AND SABA'),
('BA', 'BOSNIA AND HERZEGOVINA'),
('BW', 'BOTSWANA'),
('BV', 'BOUVET ISLAND'),
('BR', 'BRAZIL'),
('IO', 'BRITISH INDIAN OCEAN TERRITORY'),
('BN', 'BRUNEI DARUSSALAM'),
('BG', 'BULGARIA'),
('BF', 'BURKINA FASO'),
('BI', 'BURUNDI'),
('KH', 'CAMBODIA'),
('CM', 'CAMEROON'),
('CA', 'CANADA'),
('CV', 'CAPE VERDE'),
('KY', 'CAYMAN ISLANDS'),
('CF', 'CENTRAL AFRICAN REPUBLIC'),
('TD', 'CHAD'),
('CL', 'CHILE'),
('CN', 'CHINA'),
('CX', 'CHRISTMAS ISLAND'),
('CC', 'COCOS (KEELING) ISLANDS'),
('CO', 'COLOMBIA'),
('KM', 'COMOROS'),
('CG', 'CONGO'),
('CD', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE'),
('CK', 'COOK ISLANDS'),
('CR', 'COSTA RICA'),
('CI', 'CÔTE D\'IVOIRE'),
('HR', 'CROATIA'),
('CU', 'CUBA'),
('CW', 'CURAÇAO'),
('CY', 'CYPRUS'),
('CZ', 'CZECH REPUBLIC'),
('DK', 'DENMARK'),
('DJ', 'DJIBOUTI'),
('DM', 'DOMINICA'),
('DO', 'DOMINICAN REPUBLIC'),
('EC', 'ECUADOR'),
('EG', 'EGYPT'),
('SV', 'EL SALVADOR'),
('GQ', 'EQUATORIAL GUINEA'),
('ER', 'ERITREA'),
('EE', 'ESTONIA'),
('ET', 'ETHIOPIA'),
('FK', 'FALKLAND ISLANDS (MALVINAS)'),
('FO', 'FAROE ISLANDS'),
('FJ', 'FIJI'),
('FI', 'FINLAND'),
('FR', 'FRANCE'),
('GF', 'FRENCH GUIANA'),
('PF', 'FRENCH POLYNESIA'),
('TF', 'FRENCH SOUTHERN TERRITORIES'),
('GA', 'GABON'),
('GM', 'GAMBIA'),
('GE', 'GEORGIA'),
('DE', 'GERMANY'),
('GH', 'GHANA'),
('GI', 'GIBRALTAR'),
('GR', 'GREECE'),
('GL', 'GREENLAND'),
('GD', 'GRENADA'),
('GP', 'GUADELOUPE'),
('GU', 'GUAM'),
('GT', 'GUATEMALA'),
('GG', 'GUERNSEY'),
('GN', 'GUINEA'),
('GW', 'GUINEA-BISSAU'),
('GY', 'GUYANA'),
('HT', 'HAITI'),
('HM', 'HEARD ISLAND AND MCDONALD ISLANDS'),
('VA', 'HOLY SEE (VATICAN CITY STATE)'),
('HN', 'HONDURAS'),
('HK', 'HONG KONG'),
('HU', 'HUNGARY'),
('IS', 'ICELAND'),
('IN', 'INDIA'),
('ID', 'INDONESIA'),
('IR', 'IRAN, ISLAMIC REPUBLIC OF'),
('IQ', 'IRAQ'),
('IE', 'IRELAND'),
('IM', 'ISLE OF MAN'),
('IL', 'ISRAEL'),
('IT', 'ITALY'),
('JM', 'JAMAICA'),
('JP', 'JAPAN'),
('JE', 'JERSEY'),
('JO', 'JORDAN'),
('KZ', 'KAZAKHSTAN'),
('KE', 'KENYA'),
('KI', 'KIRIBATI'),
('KP', 'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF'),
('KR', 'KOREA, REPUBLIC OF'),
('KW', 'KUWAIT'),
('KG', 'KYRGYZSTAN'),
('LA', 'LAO PEOPLE\'S DEMOCRATIC REPUBLIC'),
('LV', 'LATVIA'),
('LB', 'LEBANON'),
('LS', 'LESOTHO'),
('LR', 'LIBERIA'),
('LY', 'LIBYA'),
('LI', 'LIECHTENSTEIN'),
('LT', 'LITHUANIA'),
('LU', 'LUXEMBOURG'),
('MO', 'MACAO'),
('MK', 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF'),
('MG', 'MADAGASCAR'),
('MW', 'MALAWI'),
('MY', 'MALAYSIA'),
('MV', 'MALDIVES'),
('ML', 'MALI'),
('MT', 'MALTA'),
('MH', 'MARSHALL ISLANDS'),
('MQ', 'MARTINIQUE'),
('MR', 'MAURITANIA'),
('MU', 'MAURITIUS'),
('YT', 'MAYOTTE'),
('MX', 'MEXICO'),
('FM', 'MICRONESIA, FEDERATED STATES OF'),
('MD', 'MOLDOVA, REPUBLIC OF'),
('MC', 'MONACO'),
('MN', 'MONGOLIA'),
('ME', 'MONTENEGRO'),
('MS', 'MONTSERRAT'),
('MA', 'MOROCCO'),
('MZ', 'MOZAMBIQUE'),
('MM', 'MYANMAR'),
('NA', 'NAMIBIA'),
('NR', 'NAURU'),
('NP', 'NEPAL'),
('NL', 'NETHERLANDS'),
('NC', 'NEW CALEDONIA'),
('NZ', 'NEW ZEALAND'),
('NI', 'NICARAGUA'),
('NE', 'NIGER'),
('NG', 'NIGERIA'),
('NU', 'NIUE'),
('NF', 'NORFOLK ISLAND'),
('MP', 'NORTHERN MARIANA ISLANDS'),
('NO', 'NORWAY'),
('OM', 'OMAN'),
('PK', 'PAKISTAN'),
('PW', 'PALAU'),
('PS', 'PALESTINIAN TERRITORY, OCCUPIED'),
('PA', 'PANAMA'),
('PG', 'PAPUA NEW GUINEA'),
('PY', 'PARAGUAY'),
('PE', 'PERU'),
('PH', 'PHILIPPINES'),
('PN', 'PITCAIRN'),
('PL', 'POLAND'),
('PT', 'PORTUGAL'),
('PR', 'PUERTO RICO'),
('QA', 'QATAR'),
('RE', 'RÉUNION'),
('RO', 'ROMANIA'),
('RU', 'RUSSIAN FEDERATION'),
('RW', 'RWANDA'),
('BL', 'SAINT BARTHÉLEMY'),
('SH', 'SAINT HELENA, ASCENSION AND TRISTAN DA CUNHA'),
('KN', 'SAINT KITTS AND NEVIS'),
('LC', 'SAINT LUCIA'),
('MF', 'SAINT MARTIN (FRENCH PART)'),
('PM', 'SAINT PIERRE AND MIQUELON'),
('VC', 'SAINT VINCENT AND THE GRENADINES'),
('WS', 'SAMOA'),
('SM', 'SAN MARINO'),
('ST', 'SAO TOME AND PRINCIPE'),
('SA', 'SAUDI ARABIA'),
('SN', 'SENEGAL'),
('RS', 'SERBIA'),
('SC', 'SEYCHELLES'),
('SL', 'SIERRA LEONE'),
('SG', 'SINGAPORE'),
('SX', 'SINT MAARTEN (DUTCH PART)'),
('SK', 'SLOVAKIA'),
('SI', 'SLOVENIA'),
('SB', 'SOLOMON ISLANDS'),
('SO', 'SOMALIA'),
('ZA', 'SOUTH AFRICA'),
('GS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS'),
('SS', 'SOUTH SUDAN'),
('ES', 'SPAIN'),
('LK', 'SRI LANKA'),
('SD', 'SUDAN'),
('SR', 'SURINAME'),
('SJ', 'SVALBARD AND JAN MAYEN'),
('SZ', 'SWAZILAND'),
('SE', 'SWEDEN'),
('CH', 'SWITZERLAND'),
('SY', 'SYRIAN ARAB REPUBLIC'),
('TW', 'TAIWAN, PROVINCE OF CHINA'),
('TJ', 'TAJIKISTAN'),
('TZ', 'TANZANIA, UNITED REPUBLIC OF'),
('TH', 'THAILAND'),
('TL', 'TIMOR-LESTE'),
('TG', 'TOGO'),
('TK', 'TOKELAU'),
('TO', 'TONGA'),
('TT', 'TRINIDAD AND TOBAGO'),
('TN', 'TUNISIA'),
('TR', 'TURKEY'),
('TM', 'TURKMENISTAN'),
('TC', 'TURKS AND CAICOS ISLANDS'),
('TV', 'TUVALU'),
('UG', 'UGANDA'),
('UA', 'UKRAINE'),
('AE', 'UNITED ARAB EMIRATES'),
('GB', 'UNITED KINGDOM'),
('US', 'UNITED STATES'),
('UM', 'UNITED STATES MINOR OUTLYING ISLANDS'),
('UY', 'URUGUAY'),
('UZ', 'UZBEKISTAN'),
('VU', 'VANUATU'),
('VE', 'VENEZUELA, BOLIVARIAN REPUBLIC OF'),
('VN', 'VIET NAM'),
('VG', 'VIRGIN ISLANDS, BRITISH'),
('VI', 'VIRGIN ISLANDS, U.S.'),
('WF', 'WALLIS AND FUTUNA'),
('EH', 'WESTERN SAHARA'),
('YE', 'YEMEN'),
('ZM', 'ZAMBIA'),
('ZW', 'ZIMBABWE');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Items`
--

CREATE TABLE `Items` (
  `ItemID` varchar(10) NOT NULL COMMENT 'using users short-id and a >=4-digit-sequential number - example: FK_0003',
  `Caption` varchar(100) NOT NULL COMMENT 'Freetext to describe the document',
  `Description` longtext COMMENT 'Contains detailed description and data gathered from EXIF or OCR',
  `Format` varchar(25) DEFAULT NULL COMMENT 'Freetext to describe physical source of this document - (letter, photo, whatever)',
  `Date` date DEFAULT NULL COMMENT 'originals date',
  `Sender` int(11) DEFAULT NULL COMMENT 'source (needs to be changed)',
  `Receiver` int(11) NOT NULL,
  `ScanUser` int(11) NOT NULL COMMENT 'scanning user',
  `ScanDate` date NOT NULL COMMENT 'scanning date',
  `SourceSHA256` varchar(64) NOT NULL COMMENT 'SHA256 of archived document to check for corrupted files',
  `OCRStatus` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Tags`
--

CREATE TABLE `Tags` (
  `TagID` int(11) NOT NULL,
  `ItemID` varchar(10) NOT NULL,
  `TagValue` varchar(150) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Users`
--

CREATE TABLE `Users` (
  `UserID` int(11) NOT NULL,
  `Name` varchar(150) NOT NULL,
  `Nickname` varchar(50) NOT NULL COMMENT 'aka loginname',
  `Password` varchar(72) NOT NULL COMMENT 'salted SHA256',
  `EMail` varchar(150) NOT NULL,
  `Level` int(11) NOT NULL DEFAULT '0' COMMENT 'binary system, not really documented yet',
  `UIdent` varchar(2) NOT NULL COMMENT 'two chars used as user-identifier for document IDs'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `Users`
--

INSERT INTO `Users` (`UserID`, `Name`, `Nickname`, `Password`, `EMail`, `Level`, `UIdent`) VALUES
(1, 'admin', 'admin', '3469b67ebf2b71177c3fdb9da2c3fb0e0dec73a9e9a7e3e3516f6ba4813e52dc3f283c57', 'admin@localhost', 255, 'AD');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `Contacts`
--
ALTER TABLE `Contacts`
  ADD PRIMARY KEY (`CID`);

--
-- Indizes für die Tabelle `Countries`
--
ALTER TABLE `Countries`
  ADD PRIMARY KEY (`Alpha2`),
  ADD UNIQUE KEY `Name` (`Name`);

--
-- Indizes für die Tabelle `Items`
--
ALTER TABLE `Items`
  ADD PRIMARY KEY (`ItemID`),
  ADD UNIQUE KEY `SourceSHA256` (`SourceSHA256`),
  ADD KEY `Caption` (`Caption`),
  ADD KEY `Format` (`Format`),
  ADD KEY `Sender` (`Sender`),
  ADD KEY `Receiver` (`Receiver`);
ALTER TABLE `Items` ADD FULLTEXT KEY `Description` (`Description`);

--
-- Indizes für die Tabelle `Tags`
--
ALTER TABLE `Tags`
  ADD PRIMARY KEY (`TagID`),
  ADD UNIQUE KEY `ItemID_2` (`ItemID`,`TagValue`),
  ADD KEY `TagCategory` (`TagValue`),
  ADD KEY `ItemID` (`ItemID`),
  ADD KEY `TagValue` (`TagValue`);

--
-- Indizes für die Tabelle `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Name` (`Name`),
  ADD UNIQUE KEY `EMail` (`EMail`),
  ADD UNIQUE KEY `UIdent` (`UIdent`),
  ADD UNIQUE KEY `Nickname` (`Nickname`),
  ADD UNIQUE KEY `Login` (`Nickname`,`Password`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `Contacts`
--
ALTER TABLE `Contacts`
  MODIFY `CID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `Tags`
--
ALTER TABLE `Tags`
  MODIFY `TagID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT für Tabelle `Users`
--
ALTER TABLE `Users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
