# Host: 127.0.0.1  (Version 5.5.23)
# Date: 2017-01-04 17:56:55
# Generator: MySQL-Front 5.4  (Build 4.100) - http://www.mysqlfront.de/

/*!40101 SET NAMES utf8 */;

#
# Structure for table "job_nodes"
#

CREATE TABLE `job_nodes` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `job_rule_id` int(11) NOT NULL DEFAULT '0',
  `tag` varchar(255) NOT NULL DEFAULT '',
  `index` int(11) NOT NULL DEFAULT '0',
  `tag_id` varchar(255) DEFAULT NULL,
  `class` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `job_rule_id` (`job_rule_id`),
  CONSTRAINT `job_nodes_ibfk_1` FOREIGN KEY (`job_rule_id`) REFERENCES `job_rules` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "job_nodes"
#


#
# Structure for table "jobs"
#

CREATE TABLE `jobs` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `caption` varchar(255) NOT NULL DEFAULT '',
  `zero_link` text NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "jobs"
#

REPLACE INTO `jobs` VALUES (4,'TripAdvisor','https://www.tripadvisor.ru/SiteIndex');

#
# Structure for table "job_levels"
#

CREATE TABLE `job_levels` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `job_level_unq` (`job_id`,`level`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `job_levels_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "job_levels"
#


#
# Structure for table "job_rules"
#

CREATE TABLE `job_rules` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `job_level_id` int(11) NOT NULL DEFAULT '0',
  `container_offset` int(3) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `job_level_id` (`job_level_id`),
  CONSTRAINT `job_rules_ibfk_1` FOREIGN KEY (`job_level_id`) REFERENCES `job_levels` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "job_rules"
#


#
# Structure for table "job_rule_links"
#

CREATE TABLE `job_rule_links` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `job_rule_id` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `job_rule_id` (`job_rule_id`),
  CONSTRAINT `job_rule_links_ibfk_1` FOREIGN KEY (`job_rule_id`) REFERENCES `job_rules` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "job_rule_links"
#


#
# Structure for table "job_rule_records"
#

CREATE TABLE `job_rule_records` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `job_rule_id` int(11) NOT NULL DEFAULT '0',
  `key` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`),
  KEY `job_rule_id` (`job_rule_id`),
  CONSTRAINT `job_rule_records_ibfk_1` FOREIGN KEY (`job_rule_id`) REFERENCES `job_rules` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "job_rule_records"
#


#
# Structure for table "job_regexp"
#

CREATE TABLE `job_regexp` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `job_rule_record_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `job_rule_record_id` (`job_rule_record_id`),
  CONSTRAINT `job_regexp_ibfk_1` FOREIGN KEY (`job_rule_record_id`) REFERENCES `job_rule_records` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "job_regexp"
#


#
# Structure for table "links"
#

CREATE TABLE `links` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0',
  `link` text NOT NULL,
  `link_hash` varchar(255) NOT NULL DEFAULT '',
  `handled` tinyint(3) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `link_unq` (`job_id`,`link_hash`),
  KEY `job_id` (`job_id`,`handled`),
  CONSTRAINT `links_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "links"
#


#
# Structure for table "records"
#

CREATE TABLE `records` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `link_id` int(11) NOT NULL DEFAULT '0',
  `num` int(11) unsigned NOT NULL DEFAULT '1',
  `key` varchar(255) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  `value_hash` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `record_unq` (`link_id`,`num`,`key`,`value_hash`),
  CONSTRAINT `records_ibfk_1` FOREIGN KEY (`link_id`) REFERENCES `links` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "records"
#

