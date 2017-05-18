# Host: 127.0.0.1  (Version 5.5.23)
# Date: 2017-05-18 18:09:27
# Generator: MySQL-Front 6.0  (Build 1.194)


#
# Structure for table "job_levels"
#

CREATE TABLE `job_levels` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '0',
  `base_link` text NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `job_levels_unq` (`job_id`,`level`),
  CONSTRAINT `job_levels_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "job_levels"
#


#
# Structure for table "job_groups"
#

CREATE TABLE `job_groups` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `level_id` int(11) NOT NULL DEFAULT '0',
  `notes` varchar(255) DEFAULT '',
  PRIMARY KEY (`Id`),
  KEY `level_id` (`level_id`),
  CONSTRAINT `job_groups_ibfk_1` FOREIGN KEY (`level_id`) REFERENCES `job_levels` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "job_groups"
#


#
# Structure for table "job_rules"
#

CREATE TABLE `job_rules` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `job_rules_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `job_groups` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "job_rules"
#


#
# Structure for table "users"
#

CREATE TABLE `users` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(25) NOT NULL DEFAULT '',
  `password` varchar(64) NOT NULL DEFAULT '',
  `is_admin` tinyint(3) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Data for table "users"
#

REPLACE INTO `users` VALUES (1,'admin','123',1);

#
# Structure for table "jobs"
#

CREATE TABLE `jobs` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `caption` varchar(255) NOT NULL DEFAULT '',
  `zero_link` text NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `jobs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Data for table "jobs"
#

REPLACE INTO `jobs` VALUES (1,1,'Wikipedia Актёры','https://ru.wikipedia.org/wiki/%D0%9A%D0%B0%D1%82%D0%B5%D0%B3%D0%BE%D1%80%D0%B8%D1%8F:%D0%90%D0%BA%D1%82%D1%91%D1%80%D1%8B_%D0%BF%D0%BE_%D0%B0%D0%BB%D1%84%D0%B0%D0%B2%D0%B8%D1%82%D1%83');
