# Host: localhost  (Version: 5.5.29)
# Date: 2016-12-22 07:41:27
# Generator: MySQL-Front 5.3  (Build 4.271)

/*!40101 SET NAMES utf8 */;

#
# Structure for table "jobs"
#

CREATE TABLE `jobs` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `zero_link` text NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Data for table "jobs"
#

REPLACE INTO `jobs` VALUES (1,'https://ru.wikipedia.org/wiki/%D0%9A%D0%B0%D1%82%D0%B5%D0%B3%D0%BE%D1%80%D0%B8%D1%8F:%D0%90%D0%BA%D1%82%D1%91%D1%80%D1%8B_%D0%BF%D0%BE_%D0%B0%D0%BB%D1%84%D0%B0%D0%B2%D0%B8%D1%82%D1%83');

#
# Structure for table "job_params"
#

CREATE TABLE `job_params` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `job_params_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Data for table "job_params"
#

REPLACE INTO `job_params` VALUES (1,1,1);

#
# Structure for table "job_param_links"
#

CREATE TABLE `job_param_links` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `job_param_id` int(11) NOT NULL DEFAULT '0',
  `mode` tinyint(3) NOT NULL DEFAULT '1',
  `level` int(11) DEFAULT NULL,
  `xpath` text,
  PRIMARY KEY (`Id`),
  KEY `job_param_id` (`job_param_id`),
  CONSTRAINT `job_param_links_ibfk_1` FOREIGN KEY (`job_param_id`) REFERENCES `job_params` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Data for table "job_param_links"
#

REPLACE INTO `job_param_links` VALUES (1,1,1,1,'/html/body/div[3]/div[3]/div[4]/div[2]/div[2]/div/div/div/ul/li'),(2,1,2,2,'/html/body/div[3]/div[3]/div[4]/div[2]/div[2]/div/div/div/ul/li');

#
# Structure for table "links"
#

CREATE TABLE `links` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0',
  `link` text NOT NULL,
  `link_hash` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `job_link_unq` (`job_id`,`link_hash`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `links_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Data for table "links"
#

REPLACE INTO `links` VALUES (2,1,0,'https://ru.wikipedia.org/wiki/%D0%9A%D0%B0%D1%82%D0%B5%D0%B3%D0%BE%D1%80%D0%B8%D1%8F:%D0%90%D0%BA%D1%82%D1%91%D1%80%D1%8B_%D0%BF%D0%BE_%D0%B0%D0%BB%D1%84%D0%B0%D0%B2%D0%B8%D1%82%D1%83','f518495c4aeb7df47cd2dc0da0f045a2');
