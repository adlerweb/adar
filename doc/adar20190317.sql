/*
MySQL Data Transfer
Source Host: localhost
Source Database: adar
Target Host: localhost
Target Database: adar
Date: 2019/03/17 1:20:58 PM
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for cluster
-- ----------------------------
CREATE TABLE `cluster` (
  `clusterId` int(11) NOT NULL AUTO_INCREMENT,
  `clustername` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`clusterId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for contacts
-- ----------------------------
CREATE TABLE `contacts` (
  `CID` int(11) NOT NULL AUTO_INCREMENT,
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
  `Notes` text NOT NULL,
  PRIMARY KEY (`CID`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for countries
-- ----------------------------
CREATE TABLE `countries` (
  `Alpha2` varchar(2) NOT NULL,
  `Name` varchar(128) NOT NULL,
  PRIMARY KEY (`Alpha2`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Source: http://www.iso.org/iso/country_codes/iso_3166_code_l';

-- ----------------------------
-- Table structure for items
-- ----------------------------
CREATE TABLE `items` (
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
  `OCRStatus` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ItemID`),
  UNIQUE KEY `SourceSHA256` (`SourceSHA256`),
  KEY `Caption` (`Caption`),
  KEY `Format` (`Format`),
  KEY `Sender` (`Sender`),
  KEY `Receiver` (`Receiver`),
  FULLTEXT KEY `Description` (`Description`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for papers
-- ----------------------------
CREATE TABLE `papers` (
  `paperId` int(11) NOT NULL AUTO_INCREMENT,
  `dateUpload` date DEFAULT NULL,
  `dateModerated` date DEFAULT NULL,
  `lecturerId` varchar(255) DEFAULT NULL,
  `moderatorId` varchar(255) DEFAULT NULL,
  `studentNumber` varchar(255) DEFAULT NULL,
  `coordinatorId` varchar(255) DEFAULT NULL,
  `clusterId` varchar(255) DEFAULT NULL,
  `publishedStatus` varchar(255) DEFAULT NULL,
  `abstract` blob,
  PRIMARY KEY (`paperId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for paperstatus
-- ----------------------------
CREATE TABLE `paperstatus` (
  `statusID` int(11) NOT NULL AUTO_INCREMENT,
  `statusName` varchar(255) DEFAULT NULL COMMENT 'who can view which paper',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`statusID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
CREATE TABLE `roles` (
  `roleID` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`roleID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for student
-- ----------------------------
CREATE TABLE `student` (
  `studentID` int(11) NOT NULL AUTO_INCREMENT,
  `studentNumber` int(11) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`studentID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for tags
-- ----------------------------
CREATE TABLE `tags` (
  `TagID` int(11) NOT NULL AUTO_INCREMENT,
  `ItemID` varchar(10) NOT NULL,
  `TagValue` varchar(150) NOT NULL,
  PRIMARY KEY (`TagID`),
  UNIQUE KEY `ItemID_2` (`ItemID`,`TagValue`),
  KEY `TagCategory` (`TagValue`),
  KEY `ItemID` (`ItemID`),
  KEY `TagValue` (`TagValue`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for userloginaccount
-- ----------------------------
CREATE TABLE `userloginaccount` (
  `UserId` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(255) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for users
-- ----------------------------
CREATE TABLE `users` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(150) NOT NULL,
  `Nickname` varchar(50) NOT NULL COMMENT 'aka loginname',
  `Password` varchar(72) NOT NULL COMMENT 'salted SHA256',
  `EMail` varchar(150) NOT NULL,
  `Level` varchar(11) NOT NULL DEFAULT '0' COMMENT 'binary system, not really documented yet',
  `UIdent` varchar(11) NOT NULL COMMENT 'two chars used as user-identifier for document IDs',
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Name` (`Name`),
  UNIQUE KEY `EMail` (`EMail`),
  UNIQUE KEY `UIdent` (`UIdent`),
  UNIQUE KEY `Nickname` (`Nickname`),
  UNIQUE KEY `Login` (`Nickname`,`Password`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for usertype
-- ----------------------------
CREATE TABLE `usertype` (
  `userTypeId` int(11) NOT NULL AUTO_INCREMENT,
  `typeName` varchar(255) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `contacts` VALUES ('1', 'Andrew', 'Muteka', 'm', 'home', 'home', 'home', 'home', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test');
INSERT INTO `contacts` VALUES ('2', '', '', 'u', '', '', '', '', 'DE', '', '', '', '', '');
INSERT INTO `contacts` VALUES ('3', 'Andrew', 'Muteka', 'c', 'home', '', 'home', 'home', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test');
INSERT INTO `contacts` VALUES ('4', 'Andrew', 'Muteka', 'c', 'home', '', 'home', 'home', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test');
INSERT INTO `contacts` VALUES ('5', 'Andrew', 'Muteka', 'c', 'home', '', 'home', 'home', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test');
INSERT INTO `contacts` VALUES ('6', 'test', 'test', 'u', 'test', 'test', 'test', 'test', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test');
INSERT INTO `contacts` VALUES ('7', 'test', 'test', 'u', 'test', 'test', 'test', 'test', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test');
INSERT INTO `contacts` VALUES ('8', 'test', 'test', 'u', 'test', 'test', 'test', 'test', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test');
INSERT INTO `contacts` VALUES ('9', 'test', 'test', 'u', 'test', 'test', 'test', 'test', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test');
INSERT INTO `contacts` VALUES ('10', 'test', 'test', 'u', 'test', 'test', 'test', 'test', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test');
INSERT INTO `contacts` VALUES ('11', 'test', 'test', 'u', 'test', 'test', 'test', 'test', 'NA', '1111111', '111111', 'doriva17@gmail.com', 'www.gmail.com', 'test');
INSERT INTO `contacts` VALUES ('12', 'Rendy', 'Amputu', 'm', 'home', 'home', 'home', 'home', 'NA', '1111111', '', 'amputur@gmail.com ', '', 'amputur@gmail.com ');
INSERT INTO `contacts` VALUES ('13', 'Rendy', 'Amputu', 'm', 'home', 'home', 'home', 'home', 'NA', '1111111', '', 'amputur@gmail.com ', '', 'amputur@gmail.com ');
INSERT INTO `contacts` VALUES ('14', 'Muhepa', 'Mafo', 'm', 'here', '22', '9000', 'home', 'NA', '2546813', '', 'abc@zyx.co', '', 'test');
INSERT INTO `countries` VALUES ('AF', 'AFGHANISTAN');
INSERT INTO `countries` VALUES ('AX', 'ÅLAND ISLANDS');
INSERT INTO `countries` VALUES ('AL', 'ALBANIA');
INSERT INTO `countries` VALUES ('DZ', 'ALGERIA');
INSERT INTO `countries` VALUES ('AS', 'AMERICAN SAMOA');
INSERT INTO `countries` VALUES ('AD', 'ANDORRA');
INSERT INTO `countries` VALUES ('AO', 'ANGOLA');
INSERT INTO `countries` VALUES ('AI', 'ANGUILLA');
INSERT INTO `countries` VALUES ('AQ', 'ANTARCTICA');
INSERT INTO `countries` VALUES ('AG', 'ANTIGUA AND BARBUDA');
INSERT INTO `countries` VALUES ('AR', 'ARGENTINA');
INSERT INTO `countries` VALUES ('AM', 'ARMENIA');
INSERT INTO `countries` VALUES ('AW', 'ARUBA');
INSERT INTO `countries` VALUES ('AU', 'AUSTRALIA');
INSERT INTO `countries` VALUES ('AT', 'AUSTRIA');
INSERT INTO `countries` VALUES ('AZ', 'AZERBAIJAN');
INSERT INTO `countries` VALUES ('BS', 'BAHAMAS');
INSERT INTO `countries` VALUES ('BH', 'BAHRAIN');
INSERT INTO `countries` VALUES ('BD', 'BANGLADESH');
INSERT INTO `countries` VALUES ('BB', 'BARBADOS');
INSERT INTO `countries` VALUES ('BY', 'BELARUS');
INSERT INTO `countries` VALUES ('BE', 'BELGIUM');
INSERT INTO `countries` VALUES ('BZ', 'BELIZE');
INSERT INTO `countries` VALUES ('BJ', 'BENIN');
INSERT INTO `countries` VALUES ('BM', 'BERMUDA');
INSERT INTO `countries` VALUES ('BT', 'BHUTAN');
INSERT INTO `countries` VALUES ('BO', 'BOLIVIA, PLURINATIONAL STATE OF');
INSERT INTO `countries` VALUES ('BQ', 'BONAIRE, SINT EUSTATIUS AND SABA');
INSERT INTO `countries` VALUES ('BA', 'BOSNIA AND HERZEGOVINA');
INSERT INTO `countries` VALUES ('BW', 'BOTSWANA');
INSERT INTO `countries` VALUES ('BV', 'BOUVET ISLAND');
INSERT INTO `countries` VALUES ('BR', 'BRAZIL');
INSERT INTO `countries` VALUES ('IO', 'BRITISH INDIAN OCEAN TERRITORY');
INSERT INTO `countries` VALUES ('BN', 'BRUNEI DARUSSALAM');
INSERT INTO `countries` VALUES ('BG', 'BULGARIA');
INSERT INTO `countries` VALUES ('BF', 'BURKINA FASO');
INSERT INTO `countries` VALUES ('BI', 'BURUNDI');
INSERT INTO `countries` VALUES ('KH', 'CAMBODIA');
INSERT INTO `countries` VALUES ('CM', 'CAMEROON');
INSERT INTO `countries` VALUES ('CA', 'CANADA');
INSERT INTO `countries` VALUES ('CV', 'CAPE VERDE');
INSERT INTO `countries` VALUES ('KY', 'CAYMAN ISLANDS');
INSERT INTO `countries` VALUES ('CF', 'CENTRAL AFRICAN REPUBLIC');
INSERT INTO `countries` VALUES ('TD', 'CHAD');
INSERT INTO `countries` VALUES ('CL', 'CHILE');
INSERT INTO `countries` VALUES ('CN', 'CHINA');
INSERT INTO `countries` VALUES ('CX', 'CHRISTMAS ISLAND');
INSERT INTO `countries` VALUES ('CC', 'COCOS (KEELING) ISLANDS');
INSERT INTO `countries` VALUES ('CO', 'COLOMBIA');
INSERT INTO `countries` VALUES ('KM', 'COMOROS');
INSERT INTO `countries` VALUES ('CG', 'CONGO');
INSERT INTO `countries` VALUES ('CD', 'CONGO, THE DEMOCRATIC REPUBLIC OF THE');
INSERT INTO `countries` VALUES ('CK', 'COOK ISLANDS');
INSERT INTO `countries` VALUES ('CR', 'COSTA RICA');
INSERT INTO `countries` VALUES ('CI', 'CÔTE D\'IVOIRE');
INSERT INTO `countries` VALUES ('HR', 'CROATIA');
INSERT INTO `countries` VALUES ('CU', 'CUBA');
INSERT INTO `countries` VALUES ('CW', 'CURAÇAO');
INSERT INTO `countries` VALUES ('CY', 'CYPRUS');
INSERT INTO `countries` VALUES ('CZ', 'CZECH REPUBLIC');
INSERT INTO `countries` VALUES ('DK', 'DENMARK');
INSERT INTO `countries` VALUES ('DJ', 'DJIBOUTI');
INSERT INTO `countries` VALUES ('DM', 'DOMINICA');
INSERT INTO `countries` VALUES ('DO', 'DOMINICAN REPUBLIC');
INSERT INTO `countries` VALUES ('EC', 'ECUADOR');
INSERT INTO `countries` VALUES ('EG', 'EGYPT');
INSERT INTO `countries` VALUES ('SV', 'EL SALVADOR');
INSERT INTO `countries` VALUES ('GQ', 'EQUATORIAL GUINEA');
INSERT INTO `countries` VALUES ('ER', 'ERITREA');
INSERT INTO `countries` VALUES ('EE', 'ESTONIA');
INSERT INTO `countries` VALUES ('ET', 'ETHIOPIA');
INSERT INTO `countries` VALUES ('FK', 'FALKLAND ISLANDS (MALVINAS)');
INSERT INTO `countries` VALUES ('FO', 'FAROE ISLANDS');
INSERT INTO `countries` VALUES ('FJ', 'FIJI');
INSERT INTO `countries` VALUES ('FI', 'FINLAND');
INSERT INTO `countries` VALUES ('FR', 'FRANCE');
INSERT INTO `countries` VALUES ('GF', 'FRENCH GUIANA');
INSERT INTO `countries` VALUES ('PF', 'FRENCH POLYNESIA');
INSERT INTO `countries` VALUES ('TF', 'FRENCH SOUTHERN TERRITORIES');
INSERT INTO `countries` VALUES ('GA', 'GABON');
INSERT INTO `countries` VALUES ('GM', 'GAMBIA');
INSERT INTO `countries` VALUES ('GE', 'GEORGIA');
INSERT INTO `countries` VALUES ('DE', 'GERMANY');
INSERT INTO `countries` VALUES ('GH', 'GHANA');
INSERT INTO `countries` VALUES ('GI', 'GIBRALTAR');
INSERT INTO `countries` VALUES ('GR', 'GREECE');
INSERT INTO `countries` VALUES ('GL', 'GREENLAND');
INSERT INTO `countries` VALUES ('GD', 'GRENADA');
INSERT INTO `countries` VALUES ('GP', 'GUADELOUPE');
INSERT INTO `countries` VALUES ('GU', 'GUAM');
INSERT INTO `countries` VALUES ('GT', 'GUATEMALA');
INSERT INTO `countries` VALUES ('GG', 'GUERNSEY');
INSERT INTO `countries` VALUES ('GN', 'GUINEA');
INSERT INTO `countries` VALUES ('GW', 'GUINEA-BISSAU');
INSERT INTO `countries` VALUES ('GY', 'GUYANA');
INSERT INTO `countries` VALUES ('HT', 'HAITI');
INSERT INTO `countries` VALUES ('HM', 'HEARD ISLAND AND MCDONALD ISLANDS');
INSERT INTO `countries` VALUES ('VA', 'HOLY SEE (VATICAN CITY STATE)');
INSERT INTO `countries` VALUES ('HN', 'HONDURAS');
INSERT INTO `countries` VALUES ('HK', 'HONG KONG');
INSERT INTO `countries` VALUES ('HU', 'HUNGARY');
INSERT INTO `countries` VALUES ('IS', 'ICELAND');
INSERT INTO `countries` VALUES ('IN', 'INDIA');
INSERT INTO `countries` VALUES ('ID', 'INDONESIA');
INSERT INTO `countries` VALUES ('IR', 'IRAN, ISLAMIC REPUBLIC OF');
INSERT INTO `countries` VALUES ('IQ', 'IRAQ');
INSERT INTO `countries` VALUES ('IE', 'IRELAND');
INSERT INTO `countries` VALUES ('IM', 'ISLE OF MAN');
INSERT INTO `countries` VALUES ('IL', 'ISRAEL');
INSERT INTO `countries` VALUES ('IT', 'ITALY');
INSERT INTO `countries` VALUES ('JM', 'JAMAICA');
INSERT INTO `countries` VALUES ('JP', 'JAPAN');
INSERT INTO `countries` VALUES ('JE', 'JERSEY');
INSERT INTO `countries` VALUES ('JO', 'JORDAN');
INSERT INTO `countries` VALUES ('KZ', 'KAZAKHSTAN');
INSERT INTO `countries` VALUES ('KE', 'KENYA');
INSERT INTO `countries` VALUES ('KI', 'KIRIBATI');
INSERT INTO `countries` VALUES ('KP', 'KOREA, DEMOCRATIC PEOPLE\'S REPUBLIC OF');
INSERT INTO `countries` VALUES ('KR', 'KOREA, REPUBLIC OF');
INSERT INTO `countries` VALUES ('KW', 'KUWAIT');
INSERT INTO `countries` VALUES ('KG', 'KYRGYZSTAN');
INSERT INTO `countries` VALUES ('LA', 'LAO PEOPLE\'S DEMOCRATIC REPUBLIC');
INSERT INTO `countries` VALUES ('LV', 'LATVIA');
INSERT INTO `countries` VALUES ('LB', 'LEBANON');
INSERT INTO `countries` VALUES ('LS', 'LESOTHO');
INSERT INTO `countries` VALUES ('LR', 'LIBERIA');
INSERT INTO `countries` VALUES ('LY', 'LIBYA');
INSERT INTO `countries` VALUES ('LI', 'LIECHTENSTEIN');
INSERT INTO `countries` VALUES ('LT', 'LITHUANIA');
INSERT INTO `countries` VALUES ('LU', 'LUXEMBOURG');
INSERT INTO `countries` VALUES ('MO', 'MACAO');
INSERT INTO `countries` VALUES ('MK', 'MACEDONIA, THE FORMER YUGOSLAV REPUBLIC OF');
INSERT INTO `countries` VALUES ('MG', 'MADAGASCAR');
INSERT INTO `countries` VALUES ('MW', 'MALAWI');
INSERT INTO `countries` VALUES ('MY', 'MALAYSIA');
INSERT INTO `countries` VALUES ('MV', 'MALDIVES');
INSERT INTO `countries` VALUES ('ML', 'MALI');
INSERT INTO `countries` VALUES ('MT', 'MALTA');
INSERT INTO `countries` VALUES ('MH', 'MARSHALL ISLANDS');
INSERT INTO `countries` VALUES ('MQ', 'MARTINIQUE');
INSERT INTO `countries` VALUES ('MR', 'MAURITANIA');
INSERT INTO `countries` VALUES ('MU', 'MAURITIUS');
INSERT INTO `countries` VALUES ('YT', 'MAYOTTE');
INSERT INTO `countries` VALUES ('MX', 'MEXICO');
INSERT INTO `countries` VALUES ('FM', 'MICRONESIA, FEDERATED STATES OF');
INSERT INTO `countries` VALUES ('MD', 'MOLDOVA, REPUBLIC OF');
INSERT INTO `countries` VALUES ('MC', 'MONACO');
INSERT INTO `countries` VALUES ('MN', 'MONGOLIA');
INSERT INTO `countries` VALUES ('ME', 'MONTENEGRO');
INSERT INTO `countries` VALUES ('MS', 'MONTSERRAT');
INSERT INTO `countries` VALUES ('MA', 'MOROCCO');
INSERT INTO `countries` VALUES ('MZ', 'MOZAMBIQUE');
INSERT INTO `countries` VALUES ('MM', 'MYANMAR');
INSERT INTO `countries` VALUES ('NA', 'NAMIBIA');
INSERT INTO `countries` VALUES ('NR', 'NAURU');
INSERT INTO `countries` VALUES ('NP', 'NEPAL');
INSERT INTO `countries` VALUES ('NL', 'NETHERLANDS');
INSERT INTO `countries` VALUES ('NC', 'NEW CALEDONIA');
INSERT INTO `countries` VALUES ('NZ', 'NEW ZEALAND');
INSERT INTO `countries` VALUES ('NI', 'NICARAGUA');
INSERT INTO `countries` VALUES ('NE', 'NIGER');
INSERT INTO `countries` VALUES ('NG', 'NIGERIA');
INSERT INTO `countries` VALUES ('NU', 'NIUE');
INSERT INTO `countries` VALUES ('NF', 'NORFOLK ISLAND');
INSERT INTO `countries` VALUES ('MP', 'NORTHERN MARIANA ISLANDS');
INSERT INTO `countries` VALUES ('NO', 'NORWAY');
INSERT INTO `countries` VALUES ('OM', 'OMAN');
INSERT INTO `countries` VALUES ('PK', 'PAKISTAN');
INSERT INTO `countries` VALUES ('PW', 'PALAU');
INSERT INTO `countries` VALUES ('PS', 'PALESTINIAN TERRITORY, OCCUPIED');
INSERT INTO `countries` VALUES ('PA', 'PANAMA');
INSERT INTO `countries` VALUES ('PG', 'PAPUA NEW GUINEA');
INSERT INTO `countries` VALUES ('PY', 'PARAGUAY');
INSERT INTO `countries` VALUES ('PE', 'PERU');
INSERT INTO `countries` VALUES ('PH', 'PHILIPPINES');
INSERT INTO `countries` VALUES ('PN', 'PITCAIRN');
INSERT INTO `countries` VALUES ('PL', 'POLAND');
INSERT INTO `countries` VALUES ('PT', 'PORTUGAL');
INSERT INTO `countries` VALUES ('PR', 'PUERTO RICO');
INSERT INTO `countries` VALUES ('QA', 'QATAR');
INSERT INTO `countries` VALUES ('RE', 'RÉUNION');
INSERT INTO `countries` VALUES ('RO', 'ROMANIA');
INSERT INTO `countries` VALUES ('RU', 'RUSSIAN FEDERATION');
INSERT INTO `countries` VALUES ('RW', 'RWANDA');
INSERT INTO `countries` VALUES ('BL', 'SAINT BARTHÉLEMY');
INSERT INTO `countries` VALUES ('SH', 'SAINT HELENA, ASCENSION AND TRISTAN DA CUNHA');
INSERT INTO `countries` VALUES ('KN', 'SAINT KITTS AND NEVIS');
INSERT INTO `countries` VALUES ('LC', 'SAINT LUCIA');
INSERT INTO `countries` VALUES ('MF', 'SAINT MARTIN (FRENCH PART)');
INSERT INTO `countries` VALUES ('PM', 'SAINT PIERRE AND MIQUELON');
INSERT INTO `countries` VALUES ('VC', 'SAINT VINCENT AND THE GRENADINES');
INSERT INTO `countries` VALUES ('WS', 'SAMOA');
INSERT INTO `countries` VALUES ('SM', 'SAN MARINO');
INSERT INTO `countries` VALUES ('ST', 'SAO TOME AND PRINCIPE');
INSERT INTO `countries` VALUES ('SA', 'SAUDI ARABIA');
INSERT INTO `countries` VALUES ('SN', 'SENEGAL');
INSERT INTO `countries` VALUES ('RS', 'SERBIA');
INSERT INTO `countries` VALUES ('SC', 'SEYCHELLES');
INSERT INTO `countries` VALUES ('SL', 'SIERRA LEONE');
INSERT INTO `countries` VALUES ('SG', 'SINGAPORE');
INSERT INTO `countries` VALUES ('SX', 'SINT MAARTEN (DUTCH PART)');
INSERT INTO `countries` VALUES ('SK', 'SLOVAKIA');
INSERT INTO `countries` VALUES ('SI', 'SLOVENIA');
INSERT INTO `countries` VALUES ('SB', 'SOLOMON ISLANDS');
INSERT INTO `countries` VALUES ('SO', 'SOMALIA');
INSERT INTO `countries` VALUES ('ZA', 'SOUTH AFRICA');
INSERT INTO `countries` VALUES ('GS', 'SOUTH GEORGIA AND THE SOUTH SANDWICH ISLANDS');
INSERT INTO `countries` VALUES ('SS', 'SOUTH SUDAN');
INSERT INTO `countries` VALUES ('ES', 'SPAIN');
INSERT INTO `countries` VALUES ('LK', 'SRI LANKA');
INSERT INTO `countries` VALUES ('SD', 'SUDAN');
INSERT INTO `countries` VALUES ('SR', 'SURINAME');
INSERT INTO `countries` VALUES ('SJ', 'SVALBARD AND JAN MAYEN');
INSERT INTO `countries` VALUES ('SZ', 'SWAZILAND');
INSERT INTO `countries` VALUES ('SE', 'SWEDEN');
INSERT INTO `countries` VALUES ('CH', 'SWITZERLAND');
INSERT INTO `countries` VALUES ('SY', 'SYRIAN ARAB REPUBLIC');
INSERT INTO `countries` VALUES ('TW', 'TAIWAN, PROVINCE OF CHINA');
INSERT INTO `countries` VALUES ('TJ', 'TAJIKISTAN');
INSERT INTO `countries` VALUES ('TZ', 'TANZANIA, UNITED REPUBLIC OF');
INSERT INTO `countries` VALUES ('TH', 'THAILAND');
INSERT INTO `countries` VALUES ('TL', 'TIMOR-LESTE');
INSERT INTO `countries` VALUES ('TG', 'TOGO');
INSERT INTO `countries` VALUES ('TK', 'TOKELAU');
INSERT INTO `countries` VALUES ('TO', 'TONGA');
INSERT INTO `countries` VALUES ('TT', 'TRINIDAD AND TOBAGO');
INSERT INTO `countries` VALUES ('TN', 'TUNISIA');
INSERT INTO `countries` VALUES ('TR', 'TURKEY');
INSERT INTO `countries` VALUES ('TM', 'TURKMENISTAN');
INSERT INTO `countries` VALUES ('TC', 'TURKS AND CAICOS ISLANDS');
INSERT INTO `countries` VALUES ('TV', 'TUVALU');
INSERT INTO `countries` VALUES ('UG', 'UGANDA');
INSERT INTO `countries` VALUES ('UA', 'UKRAINE');
INSERT INTO `countries` VALUES ('AE', 'UNITED ARAB EMIRATES');
INSERT INTO `countries` VALUES ('GB', 'UNITED KINGDOM');
INSERT INTO `countries` VALUES ('US', 'UNITED STATES');
INSERT INTO `countries` VALUES ('UM', 'UNITED STATES MINOR OUTLYING ISLANDS');
INSERT INTO `countries` VALUES ('UY', 'URUGUAY');
INSERT INTO `countries` VALUES ('UZ', 'UZBEKISTAN');
INSERT INTO `countries` VALUES ('VU', 'VANUATU');
INSERT INTO `countries` VALUES ('VE', 'VENEZUELA, BOLIVARIAN REPUBLIC OF');
INSERT INTO `countries` VALUES ('VN', 'VIET NAM');
INSERT INTO `countries` VALUES ('VG', 'VIRGIN ISLANDS, BRITISH');
INSERT INTO `countries` VALUES ('VI', 'VIRGIN ISLANDS, U.S.');
INSERT INTO `countries` VALUES ('WF', 'WALLIS AND FUTUNA');
INSERT INTO `countries` VALUES ('EH', 'WESTERN SAHARA');
INSERT INTO `countries` VALUES ('YE', 'YEMEN');
INSERT INTO `countries` VALUES ('ZM', 'ZAMBIA');
INSERT INTO `countries` VALUES ('ZW', 'ZIMBABWE');
INSERT INTO `items` VALUES ('AD_0001', 'children', 'test', 'children', '2019-08-08', '6', '12', '1', '2019-03-08', 'd55b9a442886c5e05678754320d27cdff8a8e96439d4877d6dd623d10fdbe541', '1');
INSERT INTO `items` VALUES ('AD_0002', 'PDF test', 'PDF test', 'pdf file', '2019-03-08', '1', '12', '1', '2019-03-08', '70ecb628ada069214ab8ff5e9f368fc7c3b86073c5d8259e5349921b98e2f854', '1');
INSERT INTO `items` VALUES ('AD_0003', 'project plan', 'project plan', 'project plan', '2019-03-09', '12', '6', '1', '2019-03-09', '1fb7c63c18a2ee28320510cce7e83908fef19f70a1501e5ce1d8834cdc2599ba', '1');
INSERT INTO `items` VALUES ('AD_0004', 'Sonic', 'Sonic and Tails', 'project plan', '2019-03-10', '1', '6', '1', '2019-03-10', '5df5107d71b5eeab44a3bb87daa7c4a54f7f3b6f64209492d2fde2039554df37', '1');
INSERT INTO `items` VALUES ('AD_0005', 'character_wallpaper_tails - Copy.png', '', 'something else', '2019-03-11', '12', '12', '1', '2019-03-11', 'c6fe184d653276954aced1d3f1545ab8c1f6cdc0a99c109acc5ab77d74552b49', '1');
INSERT INTO `roles` VALUES ('1', 'admin');
INSERT INTO `roles` VALUES ('2', 'moderator');
INSERT INTO `roles` VALUES ('3', 'supervisor');
INSERT INTO `roles` VALUES ('4', 'coordinator');
INSERT INTO `roles` VALUES ('5', 'student');
INSERT INTO `student` VALUES ('1', '200608444', 'Andrew', 'Muteka', 'male', 'Software Development');
INSERT INTO `tags` VALUES ('1', 'AD_0001', 'children');
INSERT INTO `tags` VALUES ('2', 'AD_0001', 'book');
INSERT INTO `users` VALUES ('1', 'admin', 'admin', '3469b67ebf2b71177c3fdb9da2c3fb0e0dec73a9e9a7e3e3516f6ba4813e52dc3f283c57', 'doriva17@gmail.com', '255', 'AD');
INSERT INTO `users` VALUES ('2', 'Andrew', 'andrew', 'andrew', 'andrew@tumbare.com', '255', 'AN');
INSERT INTO `users` VALUES ('3', 'test', 'test', 'test', 'tewset', '11', 'te');
INSERT INTO `users` VALUES ('4', 'test1', 'test1', 'test', 'tewset1', '11', 'q');
INSERT INTO `users` VALUES ('5', 'test2', 'test2', 'test2', 'test2', '11', 'qq');
INSERT INTO `users` VALUES ('6', 'Nic', 'Nic', 'Nic', 'Nic', '11', 'Nic');
INSERT INTO `users` VALUES ('7', 'John', 'Jon', 'rew', 'ewrwer', '11', 'jo');
