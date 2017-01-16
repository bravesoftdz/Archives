# Host: localhost  (Version 5.5.29)
# Date: 2017-01-16 07:43:35
# Generator: MySQL-Front 5.4  (Build 4.119) - http://www.mysqlfront.de/

/*!40101 SET NAMES utf8 */;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

#
# Data for table "job_levels"
#

REPLACE INTO `job_levels` VALUES (1,4,1),(2,4,2),(3,4,3),(6,4,4),(7,4,5);

#
# Structure for table "job_groups"
#

CREATE TABLE `job_groups` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `job_level_id` int(11) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `job_level_id` (`job_level_id`),
  CONSTRAINT `job_groups_ibfk_1` FOREIGN KEY (`job_level_id`) REFERENCES `job_levels` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

#
# Data for table "job_groups"
#

REPLACE INTO `job_groups` VALUES (1,1,'страна'),(2,2,NULL),(3,3,NULL),(4,3,NULL),(7,6,NULL),(8,6,NULL),(9,7,NULL),(10,7,NULL);

#
# Structure for table "job_rules"
#

CREATE TABLE `job_rules` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `container_offset` int(3) DEFAULT NULL,
  `critical_type` tinyint(3) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `group_id` (`group_id`),
  CONSTRAINT `job_rules_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `job_groups` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

#
# Data for table "job_rules"
#

REPLACE INTO `job_rules` VALUES (2,1,'ссылка на страну',2,1),(4,2,'ссылка на раздел Отели',0,2),(8,4,'ссылка на регион',8,1),(9,3,'след страница',0,2),(11,8,'ссылка на отель',9,2),(12,7,'след страница',0,2),(13,10,'альт название',0,0),(14,9,'название',0,2),(15,1,'страна',2,1);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

#
# Data for table "job_rule_records"
#

REPLACE INTO `job_rule_records` VALUES (3,13,'alt_title'),(4,14,'title'),(5,15,'ru_country');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

#
# Data for table "job_rule_links"
#

REPLACE INTO `job_rule_links` VALUES (2,2,2),(4,4,3),(8,8,4),(9,9,3),(11,11,5),(12,12,4);

#
# Structure for table "job_regexp"
#

CREATE TABLE `job_regexp` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `job_rule_id` int(11) NOT NULL DEFAULT '0',
  `regexp` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`),
  KEY `job_rule_id` (`job_rule_id`),
  CONSTRAINT `job_regexp_ibfk_1` FOREIGN KEY (`job_rule_id`) REFERENCES `job_rules` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

#
# Data for table "job_regexp"
#

REPLACE INTO `job_regexp` VALUES (1,2,'-g(\\d){3,}-'),(2,4,'/Hotels-'),(5,9,'-oa(\\d)+-');

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
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=utf8;

#
# Data for table "job_nodes"
#

REPLACE INTO `job_nodes` VALUES (2,2,'HTML',1,NULL,NULL,NULL),(3,2,'BODY',1,NULL,'ltr domn_ru lang_ru long_prices globalNav2011_reset css_commerce_buttons flat_buttons sitewide xo_pin_user_review_to_top track_back',NULL),(4,2,'DIV',3,'PAGE',' non_hotels_like desktop scopedSearch',NULL),(5,2,'DIV',4,'MAINWRAP',' ',NULL),(6,2,'DIV',1,'MAIN','SiteIndex\r\n prodp13n_jfy_overflow_visible\r\n ',NULL),(7,2,'DIV',1,'BODYCON','col poolB adjust_padding new_meta_chevron_v2',NULL),(8,2,'DIV',2,NULL,'sectionCollection',NULL),(9,2,'DIV',1,NULL,'resizingMargins',NULL),(10,2,'DIV',1,'taplc_html_sitemap_payload_0','ppr_rup ppr_priv_html_sitemap_payload',NULL),(11,2,'DIV',1,NULL,'prw_rup prw_links_sitemap_container',NULL),(12,2,'DIV',1,NULL,'world_destinations container',NULL),(13,2,'UL',1,NULL,NULL,NULL),(14,2,'LI',1,NULL,NULL,NULL),(15,2,'A',1,NULL,NULL,NULL),(30,4,'HTML',1,NULL,NULL,NULL),(31,4,'BODY',1,NULL,'ltr domn_ru lang_ru long_prices globalNav2011_reset css_commerce_buttons flat_buttons sitewide xo_pin_user_review_to_top track_back',NULL),(32,4,'DIV',3,'PAGE',' non_hotels_like desktop scopedSearch',NULL),(33,4,'DIV',1,'HEAD','',NULL),(34,4,'DIV',1,NULL,'masthead\r\n masthead_war_dropdown_enabled masthead_notification_enabled\r\n ',NULL),(35,4,'DIV',2,NULL,' tabsBar',NULL),(36,4,'UL',1,NULL,'tabs',NULL),(37,4,'LI',2,NULL,'tabItem hvrIE6',NULL),(38,4,'A',1,NULL,'tabLink pid4965',NULL),(85,8,'HTML',1,NULL,NULL,NULL),(86,8,'BODY',1,NULL,'ltr domn_ru lang_ru long_prices globalNav2011_reset css_commerce_buttons flat_buttons sitewide xo_pin_user_review_to_top track_back',NULL),(87,8,'DIV',3,'PAGE',' hotels_like desktop scopedSearch withMapIcon bg_f8',NULL),(88,8,'DIV',3,'DEALSHOME',NULL,NULL),(89,8,'DIV',1,'MAIN',NULL,NULL),(90,8,'DIV',2,NULL,'maincontent rollup',NULL),(91,8,'DIV',1,'SDTOPDESTCONTENT','topdestinations rollup',NULL),(92,8,'DIV',1,'LOCATION_LIST','deckB',NULL),(93,8,'DIV',1,'BROAD_GRID',NULL,NULL),(94,8,'DIV',1,NULL,'geos_grid',NULL),(95,8,'DIV',1,NULL,'geos_row',NULL),(96,8,'DIV',1,NULL,'geo_wrap',NULL),(97,8,'DIV',1,NULL,'geo_entry',NULL),(98,8,'DIV',1,NULL,'geo_info',NULL),(99,8,'DIV',2,NULL,'geo_name',NULL),(100,8,'A',1,NULL,NULL,NULL),(101,9,'HTML',1,NULL,NULL,NULL),(102,9,'BODY',1,NULL,'ltr domn_ru lang_ru long_prices globalNav2011_reset css_commerce_buttons flat_buttons sitewide xo_pin_user_review_to_top track_back',NULL),(103,9,'DIV',3,'PAGE',' hotels_like desktop scopedSearch withMapIcon bg_f8',NULL),(104,9,'DIV',3,'DEALSHOME',NULL,NULL),(105,9,'DIV',1,'MAIN',NULL,NULL),(106,9,'DIV',2,NULL,'maincontent rollup',NULL),(107,9,'DIV',1,'SDTOPDESTCONTENT','topdestinations rollup',NULL),(108,9,'DIV',2,NULL,'deckTools btm',NULL),(109,9,'DIV',1,NULL,'unified pagination ',NULL),(110,9,'A',1,NULL,'nav next rndBtn ui_button primary taLnk',NULL),(131,11,'HTML',1,NULL,NULL,NULL),(132,11,'BODY',1,NULL,'ltr domn_ru lang_ru long_prices globalNav2011_reset css_commerce_buttons flat_buttons sitewide xo_pin_user_review_to_top track_back',NULL),(133,11,'DIV',3,'PAGE','meta_hotels hotels_like desktop scopedSearch withMapIcon bg_f8',NULL),(134,11,'DIV',6,'MAINWRAP',' hotels_lf_redesign flexChevron ',NULL),(135,11,'DIV',2,'MAIN','Hotels\r\n condense_filters prodp13n_jfy_overflow_visible\r\n ',NULL),(136,11,'DIV',1,'BODYCON','col poolA new_meta_chevron_v2',NULL),(137,11,'DIV',3,NULL,'gridA single_col_hotels txtLnkDropDown ',NULL),(138,11,'DIV',1,NULL,'col balance',NULL),(139,11,'DIV',5,'HAC_RESULTS',NULL,NULL),(140,11,'DIV',2,NULL,'hotels_list_placement',NULL),(141,11,'DIV',1,'taplc_hotels_list_short_cells2_0','ppr_rup ppr_priv_hotels_list_short_cells2',NULL),(142,11,'DIV',1,'ACCOM_OVERVIEW','deckA hacTabLIST shortCells long_prices noDates sbs txtLnkULHover bookingEnabled firstPage ',NULL),(143,11,'DIV',3,'hotel_3259472','listing easyClear p13n_imperfect ',NULL),(144,11,'DIV',1,NULL,'prw_rup prw_meta_short_cell_listing',NULL),(145,11,'DIV',1,NULL,'meta_listing easyClear metaCacheKey msk',NULL),(146,11,'DIV',1,NULL,'metaLocationInfo nonen',NULL),(147,11,'DIV',1,NULL,'property_details easyClear',NULL),(148,11,'DIV',1,NULL,'listing_info popIndexValidation styleguide_ratings',NULL),(149,11,'DIV',1,NULL,'listing_title',NULL),(150,11,'A',1,'property_3259472','property_title ',NULL),(151,12,'HTML',1,NULL,NULL,NULL),(152,12,'BODY',1,NULL,'ltr domn_ru lang_ru long_prices globalNav2011_reset css_commerce_buttons flat_buttons sitewide xo_pin_user_review_to_top track_back',NULL),(153,12,'DIV',3,'PAGE','meta_hotels hotels_like desktop scopedSearch withMapIcon bg_f8',NULL),(154,12,'DIV',6,'MAINWRAP',' hotels_lf_redesign flexChevron ',NULL),(155,12,'DIV',2,'MAIN','Hotels\r\n condense_filters prodp13n_jfy_overflow_visible\r\n ',NULL),(156,12,'DIV',1,'BODYCON','col poolB new_meta_chevron_v2',NULL),(157,12,'DIV',3,NULL,'gridA single_col_hotels txtLnkDropDown ',NULL),(158,12,'DIV',1,NULL,'col balance',NULL),(159,12,'DIV',5,'HAC_RESULTS',NULL,NULL),(160,12,'DIV',2,NULL,'hotels_list_placement',NULL),(161,12,'DIV',1,'taplc_hotels_list_short_cells2_0','ppr_rup ppr_priv_hotels_list_short_cells2',NULL),(162,12,'DIV',1,'ACCOM_OVERVIEW','deckA hacTabLIST shortCells long_prices noDates sbs txtLnkULHover bookingEnabled firstPage ',NULL),(163,12,'DIV',40,NULL,'deckTools easyClear unified_pagination',NULL),(164,12,'DIV',2,NULL,'prw_rup prw_common_standard_pagination',NULL),(165,12,'DIV',1,NULL,'unified pagination standard_pagination',NULL),(166,12,'A',1,NULL,'nav next ui_button primary taLnk',NULL),(167,13,'HTML',1,NULL,NULL,NULL),(168,13,'BODY',1,NULL,' fall_2013_refresh_hr_top css_commerce_buttons ltr domn_ru lang_ru long_prices globalNav2011_reset hr_tabs_placement_test tabs_below_meta hr_tabs content_blocks flat_buttons sitewide xo_pin_user_review_to_top track_back',NULL),(169,13,'DIV',3,'PAGE',' non_hotels_like desktop gutterAd scopedSearch bg_f8',NULL),(170,13,'DIV',5,'taplc_poi_header_0','ppr_rup ppr_priv_poi_header',NULL),(171,13,'DIV',1,NULL,'heading_2014 hr_heading',NULL),(172,13,'DIV',1,NULL,'header_container',NULL),(173,13,'DIV',1,NULL,'full_width',NULL),(174,13,'DIV',1,'HEADING_GROUP','',NULL),(175,13,'DIV',1,NULL,'headingWrapper easyClear ',NULL),(176,13,'DIV',1,NULL,'heading_name_wrapper',NULL),(177,13,'H1',1,'HEADING','heading_name with_alt_title limit_width_800',NULL),(178,13,'SPAN',1,NULL,'altHead',NULL),(179,14,'HTML',1,NULL,NULL,NULL),(180,14,'BODY',1,NULL,' fall_2013_refresh_hr_top css_commerce_buttons ltr domn_ru lang_ru long_prices globalNav2011_reset hr_tabs_placement_test tabs_below_meta hr_tabs content_blocks flat_buttons sitewide xo_pin_user_review_to_top track_back',NULL),(181,14,'DIV',3,'PAGE',' non_hotels_like desktop gutterAd scopedSearch bg_f8',NULL),(182,14,'DIV',5,'taplc_poi_header_0','ppr_rup ppr_priv_poi_header',NULL),(183,14,'DIV',1,NULL,'heading_2014 hr_heading',NULL),(184,14,'DIV',1,NULL,'header_container',NULL),(185,14,'DIV',1,NULL,'full_width',NULL),(186,14,'DIV',1,'HEADING_GROUP','',NULL),(187,14,'DIV',1,NULL,'headingWrapper easyClear ',NULL),(188,14,'DIV',1,NULL,'heading_name_wrapper',NULL),(189,14,'H1',1,'HEADING','heading_name with_alt_title limit_width_800',NULL),(190,15,'HTML',1,NULL,NULL,NULL),(191,15,'BODY',1,NULL,'ltr domn_ru lang_ru long_prices globalNav2011_reset css_commerce_buttons flat_buttons sitewide xo_pin_user_review_to_top track_back',NULL),(192,15,'DIV',3,'PAGE',' non_hotels_like desktop scopedSearch',NULL),(193,15,'DIV',5,'MAINWRAP',' ',NULL),(194,15,'DIV',1,'MAIN','SiteIndex\r\n prodp13n_jfy_overflow_visible\r\n ',NULL),(195,15,'DIV',1,'BODYCON','col poolA adjust_padding new_meta_chevron_v2',NULL),(196,15,'DIV',2,NULL,'sectionCollection',NULL),(197,15,'DIV',1,NULL,'resizingMargins',NULL),(198,15,'DIV',1,'taplc_html_sitemap_payload_0','ppr_rup ppr_priv_html_sitemap_payload',NULL),(199,15,'DIV',1,NULL,'prw_rup prw_links_sitemap_container',NULL),(200,15,'DIV',1,NULL,'world_destinations container',NULL),(201,15,'UL',1,NULL,NULL,NULL),(202,15,'LI',1,NULL,NULL,NULL),(203,15,'A',1,NULL,NULL,NULL);

#
# Structure for table "jobs"
#

CREATE TABLE `jobs` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `caption` varchar(255) NOT NULL DEFAULT '',
  `zero_link` text NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

#
# Data for table "jobs"
#

REPLACE INTO `jobs` VALUES (4,'TripAdvisor','https://www.tripadvisor.ru/SiteIndex');

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
# Structure for table "job_messages"
#

CREATE TABLE `job_messages` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `link_id` int(11) NOT NULL DEFAULT '0',
  `job_node_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Id`),
  KEY `link_id` (`link_id`),
  KEY `job_node_id` (`job_node_id`),
  CONSTRAINT `job_messages_ibfk_1` FOREIGN KEY (`link_id`) REFERENCES `links` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `job_messages_ibfk_2` FOREIGN KEY (`job_node_id`) REFERENCES `job_nodes` (`Id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Data for table "job_messages"
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

