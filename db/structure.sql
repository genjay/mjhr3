-- MySQL dump 10.13  Distrib 5.6.24, for osx10.10 (x86_64)
--
-- Host: localhost    Database: mjhr3_development
-- ------------------------------------------------------
-- Server version	5.6.24

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `annual_leave_lists`
--

DROP TABLE IF EXISTS `annual_leave_lists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `annual_leave_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `months_of_job` int(11) DEFAULT NULL,
  `days` int(11) DEFAULT NULL,
  `memo` text COLLATE utf8_unicode_ci,
  `ou_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendars`
--

DROP TABLE IF EXISTS `calendars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendars` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `duty_date` date DEFAULT NULL,
  `is_holiday` tinyint(1) DEFAULT NULL,
  `ou_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=367 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cardtimes`
--

DROP TABLE IF EXISTS `cardtimes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cardtimes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `up_data` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `catcodes`
--

DROP TABLE IF EXISTS `catcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catcodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `m_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `col_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_stoped` tinyint(1) DEFAULT NULL,
  `ou_id` int(11) DEFAULT NULL,
  `memo` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_catcodes_on_ou_id_and_uid` (`ou_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `daily_duties`
--

DROP TABLE IF EXISTS `daily_duties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `daily_duties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL,
  `duty_date` date NOT NULL,
  `is_holiday` tinyint(1) DEFAULT NULL,
  `worktype_id` int(11) DEFAULT NULL,
  `over_a` int(11) DEFAULT '0',
  `over_b` int(11) DEFAULT '0',
  `over_c` int(11) DEFAULT '0',
  `over_h` int(11) DEFAULT '0',
  `real_on` datetime DEFAULT NULL,
  `real_off` datetime DEFAULT NULL,
  `ou_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=512 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `worktype_id` int(11) DEFAULT NULL,
  `upper_id` int(11) DEFAULT NULL,
  `is_stoped` tinyint(1) DEFAULT NULL,
  `memo` text COLLATE utf8_unicode_ci,
  `ou_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `employees_count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_departments_on_ou_id_and_uid` (`ou_id`,`uid`),
  KEY `index_departments_on_worktype_id` (`worktype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doc_forgets`
--

DROP TABLE IF EXISTS `doc_forgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_forgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `duty_date` date DEFAULT NULL,
  `on_duty_at` datetime DEFAULT NULL,
  `off_duty_at` datetime DEFAULT NULL,
  `is_closed` tinyint(1) DEFAULT NULL,
  `ou_id` int(11) DEFAULT NULL,
  `notes` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_doc_forgets_on_employee_id_and_duty_date` (`employee_id`,`duty_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doc_offworks`
--

DROP TABLE IF EXISTS `doc_offworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_offworks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `offtype_id` int(11) DEFAULT NULL,
  `offduty_begin_at` datetime DEFAULT NULL,
  `offduty_end_at` datetime DEFAULT NULL,
  `mins_offduty` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_closed` tinyint(1) DEFAULT NULL,
  `ou_id` int(11) DEFAULT NULL,
  `notes` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doc_overworks`
--

DROP TABLE IF EXISTS `doc_overworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_overworks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `duty_date` date DEFAULT NULL,
  `overwork_begin_at` datetime DEFAULT NULL,
  `overwork_end_at` datetime DEFAULT NULL,
  `mins_of_overwork` int(11) DEFAULT NULL,
  `is_closed` tinyint(1) DEFAULT NULL,
  `ou_id` int(11) DEFAULT NULL,
  `notes` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `overtype_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_doc_overworks_on_employee_id_and_duty_date` (`employee_id`,`duty_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employee_inoutlogs`
--

DROP TABLE IF EXISTS `employee_inoutlogs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_inoutlogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `action` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `begin_at` date DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `days_of_jobage` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employee_insurance_settings`
--

DROP TABLE IF EXISTS `employee_insurance_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee_insurance_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) DEFAULT NULL,
  `NHI_LV` int(11) DEFAULT NULL,
  `NHI_begin_at` date DEFAULT NULL,
  `NHI_end_at` date DEFAULT NULL,
  `NHI_subsidy_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `labor_lv` int(11) DEFAULT NULL,
  `labor_begin_at` date DEFAULT NULL,
  `labor_end_at` date DEFAULT NULL,
  `labor_subsidy_id` int(11) DEFAULT NULL,
  `LP_Lv` int(11) DEFAULT NULL,
  `LP_begin_at` date DEFAULT NULL,
  `LP_end_at` date DEFAULT NULL,
  `LP_subsidy_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_free_for_2nd` tinyint(1) DEFAULT NULL,
  `reson_for_free2nd` text COLLATE utf8_unicode_ci,
  `memo` text COLLATE utf8_unicode_ci,
  `ou_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `id_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `arrive_date` date DEFAULT NULL,
  `leave_date` date DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `sex` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marriage` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `education` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `school` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tel1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tel2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cardno` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ou_id` int(11) DEFAULT NULL,
  `memo` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_employees_on_ou_id_and_uid` (`ou_id`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=685 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insurance_settings`
--

DROP TABLE IF EXISTS `insurance_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insurance_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_stoped` tinyint(1) DEFAULT NULL,
  `memo` text COLLATE utf8_unicode_ci,
  `ou_id` int(11) DEFAULT NULL,
  `a_rate` decimal(7,4) DEFAULT NULL,
  `a_employee` decimal(10,0) DEFAULT NULL,
  `a_company` decimal(10,0) DEFAULT NULL,
  `b_rate` decimal(7,4) DEFAULT NULL,
  `b_employee` decimal(10,0) DEFAULT NULL,
  `b_company` decimal(10,0) DEFAULT NULL,
  `c_rate` decimal(7,4) DEFAULT NULL,
  `c_employee` decimal(10,0) DEFAULT NULL,
  `c_company` decimal(10,0) DEFAULT NULL,
  `d_rate` decimal(7,4) DEFAULT NULL,
  `d_employee` decimal(10,0) DEFAULT NULL,
  `d_company` decimal(10,0) DEFAULT NULL,
  `e_rate` decimal(7,4) DEFAULT NULL,
  `e_employee` decimal(10,0) DEFAULT NULL,
  `e_company` decimal(10,0) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_insurance_settings_on_ou_id_and_uid` (`ou_id`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lvlists`
--

DROP TABLE IF EXISTS `lvlists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lvlists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `amt` int(11) DEFAULT NULL,
  `ou_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_lvlists_on_ou_id_and_uid` (`ou_id`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `offtypes`
--

DROP TABLE IF EXISTS `offtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `offtypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mins_of_minimum` int(11) DEFAULT NULL,
  `mins_per_unit` int(11) DEFAULT NULL,
  `deduct_percent` decimal(7,4) DEFAULT NULL,
  `include_holiday` tinyint(1) DEFAULT NULL,
  `can_duplicate` tinyint(1) DEFAULT NULL,
  `is_quota_ctrl` tinyint(1) DEFAULT NULL,
  `is_stoped` tinyint(1) DEFAULT NULL,
  `memo` text COLLATE utf8_unicode_ci,
  `ou_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_offtypes_on_ou_id_and_uid` (`ou_id`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ous`
--

DROP TABLE IF EXISTS `ous`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ous` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `overwork_hours_for_freetax` int(11) DEFAULT NULL,
  `days_per_month` int(11) DEFAULT NULL,
  `hours_per_day` int(11) DEFAULT NULL,
  `LP_rate` decimal(5,2) DEFAULT NULL,
  `welfare_rate` decimal(5,2) DEFAULT NULL,
  `memo` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `overtypes`
--

DROP TABLE IF EXISTS `overtypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `overtypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mins_of_A` int(11) DEFAULT NULL,
  `mins_of_B` int(11) DEFAULT NULL,
  `rate_of_A` decimal(7,4) DEFAULT NULL,
  `amt_of_A` decimal(10,0) DEFAULT NULL,
  `rate_of_B` decimal(7,4) DEFAULT NULL,
  `amt_of_B` decimal(10,0) DEFAULT NULL,
  `rate_of_C` decimal(7,4) DEFAULT NULL,
  `amt_of_C` decimal(10,0) DEFAULT NULL,
  `rate_of_H` decimal(7,4) DEFAULT NULL,
  `amt_of_H` decimal(10,0) DEFAULT NULL,
  `mins_per_unit` int(11) DEFAULT NULL,
  `valid_unit` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_stoped` tinyint(1) DEFAULT NULL,
  `pay_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `memo` text COLLATE utf8_unicode_ci,
  `ou_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_overtypes_on_ou_id_and_uid` (`ou_id`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pay_types`
--

DROP TABLE IF EXISTS `pay_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pay_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cycle_unit` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rule_for_break` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_stoped` tinyint(1) DEFAULT NULL,
  `ou_id` int(11) DEFAULT NULL,
  `memo` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_pay_types_on_ou_id_and_uid` (`ou_id`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sch_deps`
--

DROP TABLE IF EXISTS `sch_deps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sch_deps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ou_id` int(11) DEFAULT NULL,
  `duty_date` date DEFAULT NULL,
  `is_holiday` tinyint(1) DEFAULT NULL,
  `worktype_id` int(11) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_sch_deps_on_department_id_and_duty_date` (`department_id`,`duty_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sch_emps`
--

DROP TABLE IF EXISTS `sch_emps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sch_emps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ou_id` int(11) DEFAULT NULL,
  `duty_date` date DEFAULT NULL,
  `is_holiday` tinyint(1) DEFAULT NULL,
  `worktype_id` int(11) DEFAULT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_sch_emps_on_employee_id_and_duty_date` (`employee_id`,`duty_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subsidies`
--

DROP TABLE IF EXISTS `subsidies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subsidies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `rate` decimal(7,4) DEFAULT NULL,
  `memo` text COLLATE utf8_unicode_ci,
  `is_stoped` tinyint(1) DEFAULT NULL,
  `ou_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_subsidies_on_ou_id_and_uid` (`ou_id`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `view_sch_deps`
--

DROP TABLE IF EXISTS `view_sch_deps`;
/*!50001 DROP VIEW IF EXISTS `view_sch_deps`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_sch_deps` AS SELECT 
 1 AS `id`,
 1 AS `department_id`,
 1 AS `ou_id`,
 1 AS `uid`,
 1 AS `name`,
 1 AS `duty_date`,
 1 AS `worktype_id`,
 1 AS `is_holiday`,
 1 AS `notes`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_sch_emps`
--

DROP TABLE IF EXISTS `view_sch_emps`;
/*!50001 DROP VIEW IF EXISTS `view_sch_emps`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_sch_emps` AS SELECT 
 1 AS `id`,
 1 AS `employee_id`,
 1 AS `ou_id`,
 1 AS `uid`,
 1 AS `name`,
 1 AS `duty_date`,
 1 AS `worktype_id`,
 1 AS `is_holiday`,
 1 AS `notes`,
 1 AS `department_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `workrests`
--

DROP TABLE IF EXISTS `workrests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workrests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `worktype_id` int(11) DEFAULT NULL,
  `is_holiday` tinyint(1) DEFAULT NULL,
  `rest_begin_at` time DEFAULT NULL,
  `mins_of_rest` int(11) DEFAULT NULL,
  `is_deduct_for_duty` tinyint(1) DEFAULT NULL,
  `memo` text COLLATE utf8_unicode_ci,
  `ou_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_workrests_on_worktype_id` (`worktype_id`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `worktypes`
--

DROP TABLE IF EXISTS `worktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `worktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `on_duty_at` time DEFAULT NULL,
  `off_duty_at` time DEFAULT NULL,
  `buffer_before_duty` int(11) DEFAULT NULL,
  `buffer_after_duty` int(11) DEFAULT NULL,
  `minimum_before_overwork` int(11) DEFAULT NULL,
  `minimum_after_overwork` int(11) DEFAULT NULL,
  `minimum_holiday_overwork` int(11) DEFAULT NULL,
  `range_on` int(11) DEFAULT NULL,
  `range_off` int(11) DEFAULT NULL,
  `is_stoped` tinyint(1) DEFAULT NULL,
  `mins_of_duty` int(11) DEFAULT NULL,
  `memo` text COLLATE utf8_unicode_ci,
  `ou_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_worktypes_on_ou_id_and_uid` (`ou_id`,`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `view_sch_deps`
--

/*!50001 DROP VIEW IF EXISTS `view_sch_deps`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_sch_deps` AS select ifnull(`c`.`id`,0) AS `id`,`a`.`id` AS `department_id`,`a`.`ou_id` AS `ou_id`,`a`.`uid` AS `uid`,`a`.`name` AS `name`,`b`.`duty_date` AS `duty_date`,(case when (`c`.`worktype_id` is not null) then `c`.`worktype_id` else `a`.`worktype_id` end) AS `worktype_id`,(case when (`c`.`is_holiday` is not null) then `c`.`is_holiday` else `b`.`is_holiday` end) AS `is_holiday`,(case when (`c`.`worktype_id` is not null) then 'sch_deps' else 'departments' end) AS `notes` from ((`departments` `a` left join `calendars` `b` on((`a`.`ou_id` = `b`.`ou_id`))) left join `sch_deps` `c` on(((`c`.`department_id` = `a`.`id`) and (`c`.`duty_date` = `b`.`duty_date`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_sch_emps`
--

/*!50001 DROP VIEW IF EXISTS `view_sch_emps`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_sch_emps` AS select ifnull(`c`.`id`,0) AS `id`,`a`.`id` AS `employee_id`,`a`.`ou_id` AS `ou_id`,`a`.`uid` AS `uid`,`a`.`name` AS `name`,`b`.`duty_date` AS `duty_date`,(case when (`c`.`worktype_id` is not null) then `c`.`worktype_id` when (`d`.`worktype_id` is not null) then `d`.`worktype_id` else `e`.`worktype_id` end) AS `worktype_id`,(case when (`c`.`is_holiday` is not null) then `c`.`is_holiday` when (`d`.`is_holiday` is not null) then `d`.`is_holiday` else `b`.`is_holiday` end) AS `is_holiday`,(case when (`c`.`worktype_id` is not null) then 'sch_emps' when (`d`.`worktype_id` is not null) then 'sch_deps' else 'departments' end) AS `notes`,`e`.`id` AS `department_id` from ((((`employees` `a` left join `calendars` `b` on(((`a`.`ou_id` = `b`.`ou_id`) and (`b`.`duty_date` >= `a`.`arrive_date`) and (`b`.`duty_date` <= ifnull(`a`.`leave_date`,'99991231'))))) left join `sch_emps` `c` on(((`a`.`id` = `c`.`employee_id`) and (`c`.`duty_date` = `b`.`duty_date`)))) left join `sch_deps` `d` on(((`d`.`department_id` = `a`.`department_id`) and (`d`.`duty_date` = `b`.`duty_date`)))) left join `departments` `e` on((`e`.`id` = `a`.`department_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-07-23 13:27:22
INSERT INTO schema_migrations (version) VALUES ('20150601093620');

INSERT INTO schema_migrations (version) VALUES ('20150601093625');

INSERT INTO schema_migrations (version) VALUES ('20150601093632');

INSERT INTO schema_migrations (version) VALUES ('20150601093637');

INSERT INTO schema_migrations (version) VALUES ('20150601093641');

INSERT INTO schema_migrations (version) VALUES ('20150601093646');

INSERT INTO schema_migrations (version) VALUES ('20150602083907');

INSERT INTO schema_migrations (version) VALUES ('20150602092427');

INSERT INTO schema_migrations (version) VALUES ('20150603021618');

INSERT INTO schema_migrations (version) VALUES ('20150604024348');

INSERT INTO schema_migrations (version) VALUES ('20150604040923');

INSERT INTO schema_migrations (version) VALUES ('20150604041817');

INSERT INTO schema_migrations (version) VALUES ('20150604055553');

INSERT INTO schema_migrations (version) VALUES ('20150605074919');

INSERT INTO schema_migrations (version) VALUES ('20150608084850');

INSERT INTO schema_migrations (version) VALUES ('20150608133224');

INSERT INTO schema_migrations (version) VALUES ('20150612030029');

INSERT INTO schema_migrations (version) VALUES ('20150615032105');

INSERT INTO schema_migrations (version) VALUES ('20150615032222');

INSERT INTO schema_migrations (version) VALUES ('20150714064212');

INSERT INTO schema_migrations (version) VALUES ('20150715025739');

INSERT INTO schema_migrations (version) VALUES ('20150715034654');

INSERT INTO schema_migrations (version) VALUES ('20150715054337');

INSERT INTO schema_migrations (version) VALUES ('20150715065835');

INSERT INTO schema_migrations (version) VALUES ('20150716085938');

INSERT INTO schema_migrations (version) VALUES ('20150717081415');

INSERT INTO schema_migrations (version) VALUES ('20150720071610');

INSERT INTO schema_migrations (version) VALUES ('20150722070306');

INSERT INTO schema_migrations (version) VALUES ('20150723052707');

