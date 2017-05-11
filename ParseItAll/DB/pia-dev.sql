# Host: 127.0.0.1  (Version 5.5.23)
# Date: 2017-05-10 17:58:16
# Generator: MySQL-Front 6.0  (Build 1.163)


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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "jobs"
#

