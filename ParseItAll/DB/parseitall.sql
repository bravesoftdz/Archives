# Host: localhost  (Version 5.5.29)
# Date: 2017-01-04 23:26:32
# Generator: MySQL-Front 5.4  (Build 4.102) - http://www.mysqlfront.de/

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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

#
# Data for table "job_nodes"
#

REPLACE INTO `job_nodes` VALUES (2,2,'HTML',1,NULL,NULL,NULL),(3,2,'BODY',1,NULL,'ltr domn_ru lang_ru long_prices globalNav2011_reset css_commerce_buttons flat_buttons sitewide xo_pin_user_review_to_top track_back',NULL),(4,2,'DIV',3,'PAGE',' non_hotels_like desktop scopedSearch',NULL),(5,2,'DIV',4,'MAINWRAP',' ',NULL),(6,2,'DIV',1,'MAIN','SiteIndex\r\n prodp13n_jfy_overflow_visible\r\n ',NULL),(7,2,'DIV',1,'BODYCON','col poolB adjust_padding new_meta_chevron_v2',NULL),(8,2,'DIV',2,NULL,'sectionCollection',NULL),(9,2,'DIV',1,NULL,'resizingMargins',NULL),(10,2,'DIV',1,'taplc_html_sitemap_payload_0','ppr_rup ppr_priv_html_sitemap_payload',NULL),(11,2,'DIV',1,NULL,'prw_rup prw_links_sitemap_container',NULL),(12,2,'DIV',1,NULL,'world_destinations container',NULL),(13,2,'UL',1,NULL,NULL,NULL),(14,2,'LI',1,NULL,NULL,NULL),(15,2,'A',1,NULL,NULL,NULL),(16,3,'HTML',1,NULL,NULL,NULL),(17,3,'BODY',1,NULL,'ltr domn_ru lang_ru long_prices globalNav2011_reset css_commerce_buttons flat_buttons sitewide xo_pin_user_review_to_top track_back',NULL),(18,3,'DIV',3,'PAGE',' non_hotels_like desktop scopedSearch',NULL),(19,3,'DIV',4,'MAINWRAP',' ',NULL),(20,3,'DIV',1,'MAIN','SiteIndex\r\n prodp13n_jfy_overflow_visible\r\n ',NULL),(21,3,'DIV',1,'BODYCON','col poolB adjust_padding new_meta_chevron_v2',NULL),(22,3,'DIV',2,NULL,'sectionCollection',NULL),(23,3,'DIV',1,NULL,'resizingMargins',NULL),(24,3,'DIV',1,'taplc_html_sitemap_payload_0','ppr_rup ppr_priv_html_sitemap_payload',NULL),(25,3,'DIV',1,NULL,'prw_rup prw_links_sitemap_container',NULL),(26,3,'DIV',1,NULL,'world_destinations container',NULL),(27,3,'UL',1,NULL,NULL,NULL),(28,3,'LI',1,NULL,NULL,NULL),(29,3,'A',1,NULL,NULL,NULL);

#
# Structure for table "jobs"
#

CREATE TABLE `jobs` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `caption` varchar(255) NOT NULL DEFAULT '',
  `zero_link` text NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Data for table "job_levels"
#

REPLACE INTO `job_levels` VALUES (1,4,1);

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

#
# Data for table "job_rules"
#

REPLACE INTO `job_rules` VALUES (2,1,2),(3,1,2);

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Data for table "job_rule_links"
#

REPLACE INTO `job_rule_links` VALUES (2,2,2);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

#
# Data for table "job_rule_records"
#

REPLACE INTO `job_rule_records` VALUES (1,3,'country');

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

