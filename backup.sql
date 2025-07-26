/*!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.6.18-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: gc_enterprise
-- ------------------------------------------------------
-- Server version	10.6.18-MariaDB-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `gc_enterprise`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `gc_enterprise` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `gc_enterprise`;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'Mitarbeiter');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (2,1,117),(3,1,118),(4,1,119),(1,1,120);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=185 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add historical Gruppe Honorarklasse',7,'add_historicalfeegroup'),(26,'Can change historical Gruppe Honorarklasse',7,'change_historicalfeegroup'),(27,'Can delete historical Gruppe Honorarklasse',7,'delete_historicalfeegroup'),(28,'Can view historical Gruppe Honorarklasse',7,'view_historicalfeegroup'),(29,'Can add Gruppe Honorarklasse',8,'add_feegroup'),(30,'Can change Gruppe Honorarklasse',8,'change_feegroup'),(31,'Can delete Gruppe Honorarklasse',8,'delete_feegroup'),(32,'Can view Gruppe Honorarklasse',8,'view_feegroup'),(33,'Can add historical Leistungsphase',9,'add_historicalservicephase'),(34,'Can change historical Leistungsphase',9,'change_historicalservicephase'),(35,'Can delete historical Leistungsphase',9,'delete_historicalservicephase'),(36,'Can view historical Leistungsphase',9,'view_historicalservicephase'),(37,'Can add Leistungsphase',10,'add_servicephase'),(38,'Can change Leistungsphase',10,'change_servicephase'),(39,'Can delete Leistungsphase',10,'delete_servicephase'),(40,'Can view Leistungsphase',10,'view_servicephase'),(41,'Can add historical Dokumenttyp',11,'add_historicaldocumenttype'),(42,'Can change historical Dokumenttyp',11,'change_historicaldocumenttype'),(43,'Can delete historical Dokumenttyp',11,'delete_historicaldocumenttype'),(44,'Can view historical Dokumenttyp',11,'view_historicaldocumenttype'),(45,'Can add Dokumenttyp',12,'add_documenttype'),(46,'Can change Dokumenttyp',12,'change_documenttype'),(47,'Can delete Dokumenttyp',12,'delete_documenttype'),(48,'Can view Dokumenttyp',12,'view_documenttype'),(49,'Can add historical Dokument',13,'add_historicaldocument'),(50,'Can change historical Dokument',13,'change_historicaldocument'),(51,'Can delete historical Dokument',13,'delete_historicaldocument'),(52,'Can view historical Dokument',13,'view_historicaldocument'),(53,'Can add Dokument',14,'add_document'),(54,'Can change Dokument',14,'change_document'),(55,'Can delete Dokument',14,'delete_document'),(56,'Can view Dokument',14,'view_document'),(57,'Can add historical Steuerart',15,'add_historicalvat'),(58,'Can change historical Steuerart',15,'change_historicalvat'),(59,'Can delete historical Steuerart',15,'delete_historicalvat'),(60,'Can view historical Steuerart',15,'view_historicalvat'),(61,'Can add Steuerart',16,'add_vat'),(62,'Can change Steuerart',16,'change_vat'),(63,'Can delete Steuerart',16,'delete_vat'),(64,'Can view Steuerart',16,'view_vat'),(65,'Can add historical Projekt',17,'add_historicalorder'),(66,'Can change historical Projekt',17,'change_historicalorder'),(67,'Can delete historical Projekt',17,'delete_historicalorder'),(68,'Can view historical Projekt',17,'view_historicalorder'),(69,'Can add Projekt',18,'add_order'),(70,'Can change Projekt',18,'change_order'),(71,'Can delete Projekt',18,'delete_order'),(72,'Can view Projekt',18,'view_order'),(73,'Can add historical Besondere Leistungen',19,'add_historicalorderlineitem'),(74,'Can change historical Besondere Leistungen',19,'change_historicalorderlineitem'),(75,'Can delete historical Besondere Leistungen',19,'delete_historicalorderlineitem'),(76,'Can view historical Besondere Leistungen',19,'view_historicalorderlineitem'),(77,'Can add Besondere Leistungen',20,'add_orderlineitem'),(78,'Can change Besondere Leistungen',20,'change_orderlineitem'),(79,'Can delete Besondere Leistungen',20,'delete_orderlineitem'),(80,'Can view Besondere Leistungen',20,'view_orderlineitem'),(81,'Can add historical Projekt Leistungsphase',21,'add_historicalorderservicephase'),(82,'Can change historical Projekt Leistungsphase',21,'change_historicalorderservicephase'),(83,'Can delete historical Projekt Leistungsphase',21,'delete_historicalorderservicephase'),(84,'Can view historical Projekt Leistungsphase',21,'view_historicalorderservicephase'),(85,'Can add Projekt Leistungsphase',22,'add_orderservicephase'),(86,'Can change Projekt Leistungsphase',22,'change_orderservicephase'),(87,'Can delete Projekt Leistungsphase',22,'delete_orderservicephase'),(88,'Can view Projekt Leistungsphase',22,'view_orderservicephase'),(89,'Can add historical Projekt Honorargruppe',23,'add_historicalorderfeegroup'),(90,'Can change historical Projekt Honorargruppe',23,'change_historicalorderfeegroup'),(91,'Can delete historical Projekt Honorargruppe',23,'delete_historicalorderfeegroup'),(92,'Can view historical Projekt Honorargruppe',23,'view_historicalorderfeegroup'),(93,'Can add Projekt Honorargruppe',24,'add_orderfeegroup'),(94,'Can change Projekt Honorargruppe',24,'change_orderfeegroup'),(95,'Can delete Projekt Honorargruppe',24,'delete_orderfeegroup'),(96,'Can view Projekt Honorargruppe',24,'view_orderfeegroup'),(97,'Can add historical Pauschale',25,'add_historicalflatfee'),(98,'Can change historical Pauschale',25,'change_historicalflatfee'),(99,'Can delete historical Pauschale',25,'delete_historicalflatfee'),(100,'Can view historical Pauschale',25,'view_historicalflatfee'),(101,'Can add Pauschale',26,'add_flatfee'),(102,'Can change Pauschale',26,'change_flatfee'),(103,'Can delete Pauschale',26,'delete_flatfee'),(104,'Can view Pauschale',26,'view_flatfee'),(105,'Can add historical Aufgabe',27,'add_historicaltask'),(106,'Can change historical Aufgabe',27,'change_historicaltask'),(107,'Can delete historical Aufgabe',27,'delete_historicaltask'),(108,'Can view historical Aufgabe',27,'view_historicaltask'),(109,'Can add Aufgabe',28,'add_task'),(110,'Can change Aufgabe',28,'change_task'),(111,'Can delete Aufgabe',28,'delete_task'),(112,'Can view Aufgabe',28,'view_task'),(113,'Can add historical task position',29,'add_historicaltaskposition'),(114,'Can change historical task position',29,'change_historicaltaskposition'),(115,'Can delete historical task position',29,'delete_historicaltaskposition'),(116,'Can view historical task position',29,'view_historicaltaskposition'),(117,'Can add task position',30,'add_taskposition'),(118,'Can change task position',30,'change_taskposition'),(119,'Can delete task position',30,'delete_taskposition'),(120,'Can view task position',30,'view_taskposition'),(121,'Can add historical Tag',31,'add_historicaltag'),(122,'Can change historical Tag',31,'change_historicaltag'),(123,'Can delete historical Tag',31,'delete_historicaltag'),(124,'Can view historical Tag',31,'view_historicaltag'),(125,'Can add Tag',32,'add_tag'),(126,'Can change Tag',32,'change_tag'),(127,'Can delete Tag',32,'delete_tag'),(128,'Can view Tag',32,'view_tag'),(129,'Can add historical Kunde',33,'add_historicalcustomer'),(130,'Can change historical Kunde',33,'change_historicalcustomer'),(131,'Can delete historical Kunde',33,'delete_historicalcustomer'),(132,'Can view historical Kunde',33,'view_historicalcustomer'),(133,'Can add Kunde',34,'add_customer'),(134,'Can change Kunde',34,'change_customer'),(135,'Can delete Kunde',34,'delete_customer'),(136,'Can view Kunde',34,'view_customer'),(137,'Can add historical Kundenkontakt',35,'add_historicalcustomercontact'),(138,'Can change historical Kundenkontakt',35,'change_historicalcustomercontact'),(139,'Can delete historical Kundenkontakt',35,'delete_historicalcustomercontact'),(140,'Can view historical Kundenkontakt',35,'view_historicalcustomercontact'),(141,'Can add Kundenkontakt',36,'add_customercontact'),(142,'Can change Kundenkontakt',36,'change_customercontact'),(143,'Can delete Kundenkontakt',36,'delete_customercontact'),(144,'Can view Kundenkontakt',36,'view_customercontact'),(145,'Can add historical Firma',37,'add_historicalcompany'),(146,'Can change historical Firma',37,'change_historicalcompany'),(147,'Can delete historical Firma',37,'delete_historicalcompany'),(148,'Can view historical Firma',37,'view_historicalcompany'),(149,'Can add Firma',38,'add_company'),(150,'Can change Firma',38,'change_company'),(151,'Can delete Firma',38,'delete_company'),(152,'Can view Firma',38,'view_company'),(153,'Can add historical Auftragszähler',39,'add_historicalordercounter'),(154,'Can change historical Auftragszähler',39,'change_historicalordercounter'),(155,'Can delete historical Auftragszähler',39,'delete_historicalordercounter'),(156,'Can view historical Auftragszähler',39,'view_historicalordercounter'),(157,'Can add Auftragszähler',40,'add_ordercounter'),(158,'Can change Auftragszähler',40,'change_ordercounter'),(159,'Can delete Auftragszähler',40,'delete_ordercounter'),(160,'Can view Auftragszähler',40,'view_ordercounter'),(161,'Can add historical Ansprechpartner',41,'add_historicalcontact'),(162,'Can change historical Ansprechpartner',41,'change_historicalcontact'),(163,'Can delete historical Ansprechpartner',41,'delete_historicalcontact'),(164,'Can view historical Ansprechpartner',41,'view_historicalcontact'),(165,'Can add Ansprechpartner',42,'add_contact'),(166,'Can change Ansprechpartner',42,'change_contact'),(167,'Can delete Ansprechpartner',42,'delete_contact'),(168,'Can view Ansprechpartner',42,'view_contact'),(169,'Can add historical Bank',43,'add_historicalbank'),(170,'Can change historical Bank',43,'change_historicalbank'),(171,'Can delete historical Bank',43,'delete_historicalbank'),(172,'Can view historical Bank',43,'view_historicalbank'),(173,'Can add Bank',44,'add_bank'),(174,'Can change Bank',44,'change_bank'),(175,'Can delete Bank',44,'delete_bank'),(176,'Can view Bank',44,'view_bank'),(177,'Can add historical Social Media',45,'add_historicalsocialmedia'),(178,'Can change historical Social Media',45,'change_historicalsocialmedia'),(179,'Can delete historical Social Media',45,'delete_historicalsocialmedia'),(180,'Can view historical Social Media',45,'view_historicalsocialmedia'),(181,'Can add Social Media',46,'add_socialmedia'),(182,'Can change Social Media',46,'change_socialmedia'),(183,'Can delete Social Media',46,'delete_socialmedia'),(184,'Can view Social Media',46,'view_socialmedia');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$870000$Gignr6BJgQaHJgUD7rrPzV$eZ14a+kygplxNlgWmultQNBnIVbJ2gvE+aEwqfharX8=','2025-07-17 18:55:18.947605',1,'get-company','Florian','Buchner','contact@get-company.com',1,1,'2025-01-17 19:44:30.000000'),(3,'pbkdf2_sha256$870000$jkQDxA6Vo7t8iHhGANCDsc$QK8L41pMgE4Grj4b6y5viMeLTcehIMjO+DyLFyaQcqE=','2025-01-29 14:55:16.151310',0,'kfeder','Kathrin','Feder','',1,1,'2025-01-29 13:04:38.000000'),(4,'pbkdf2_sha256$870000$HTsyn1NWya0ib7Q1dZYTEf$Crvp8/GfvVnNMKCEoMwzDepH0L/INTqbl9sPbuNUIaA=','2025-02-26 05:09:06.028246',1,'riesemann','Mathias','Riesemann','m.riesemann@ib-riesemann.de',1,1,'2025-01-29 13:09:10.000000');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (1,3,1);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_bank`
--

DROP TABLE IF EXISTS `company_bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_bank` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `iban` varchar(34) NOT NULL,
  `bic` varchar(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `company_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `company_bank_created_by_id_ad10ff12_fk_auth_user_id` (`created_by_id`),
  KEY `company_bank_updated_by_id_38fcef0c_fk_auth_user_id` (`updated_by_id`),
  KEY `company_bank_company_id_76ee888f_fk_company_company_id` (`company_id`),
  CONSTRAINT `company_bank_company_id_76ee888f_fk_company_company_id` FOREIGN KEY (`company_id`) REFERENCES `company_company` (`id`),
  CONSTRAINT `company_bank_created_by_id_ad10ff12_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `company_bank_updated_by_id_38fcef0c_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_bank`
--

LOCK TABLES `company_bank` WRITE;
/*!40000 ALTER TABLE `company_bank` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_bank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_company`
--

DROP TABLE IF EXISTS `company_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `vat_id` varchar(50) NOT NULL,
  `court_register` varchar(50) DEFAULT NULL,
  `court` varchar(255) DEFAULT NULL,
  `street` varchar(255) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `city` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `phone_number` varchar(128) NOT NULL,
  `fax_number` varchar(128) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `website` varchar(200) DEFAULT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `signature` varchar(100) DEFAULT NULL,
  `prefix` varchar(5) DEFAULT NULL,
  `suffix` varchar(5) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `contact_person_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `company_company_contact_person_id_3fa026d0_fk_company_contact_id` (`contact_person_id`),
  KEY `company_company_created_by_id_cf02c06b_fk_auth_user_id` (`created_by_id`),
  KEY `company_company_updated_by_id_c828f0c5_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `company_company_contact_person_id_3fa026d0_fk_company_contact_id` FOREIGN KEY (`contact_person_id`) REFERENCES `company_contact` (`id`),
  CONSTRAINT `company_company_created_by_id_cf02c06b_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `company_company_updated_by_id_c828f0c5_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_company`
--

LOCK TABLES `company_company` WRITE;
/*!40000 ALTER TABLE `company_company` DISABLE KEYS */;
INSERT INTO `company_company` VALUES (1,'2025-01-21 20:01:13.000000','2025-01-21 20:02:06.148749','IB Riesemann GmbH','DE259678911','HRB 22261','Amtsgericht Traunstein','Adelholzener Str. 34','83313','Siegsdorf','Deutschland','+4986624850000','+49866212455','info@ib-riesemann.de','https://www.ib-riesemann.com/','company/company_logos/IBR_Riesemann_GmbH_Logo_Uw2Dcqc.jpg','company/company_logos/signature_03lg01r.png',NULL,NULL,1,1,1);
/*!40000 ALTER TABLE `company_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_contact`
--

DROP TABLE IF EXISTS `company_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_contact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `role` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone_number` varchar(128) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `company_contact_created_by_id_623cf7c2_fk_auth_user_id` (`created_by_id`),
  KEY `company_contact_updated_by_id_d912a879_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `company_contact_created_by_id_623cf7c2_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `company_contact_updated_by_id_d912a879_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_contact`
--

LOCK TABLES `company_contact` WRITE;
/*!40000 ALTER TABLE `company_contact` DISABLE KEYS */;
INSERT INTO `company_contact` VALUES (1,'2025-01-21 20:01:56.023592','2025-01-21 20:01:56.023609','Dipl.-Ing.  Mathias','Riesemann B.Sc.','Geschäftsführer','info@ib-riesemann.de','+4986624850000',1,1);
/*!40000 ALTER TABLE `company_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_historicalbank`
--

DROP TABLE IF EXISTS `company_historicalbank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_historicalbank` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `iban` varchar(34) NOT NULL,
  `bic` varchar(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `company_historicalbank_history_user_id_4c60ee67_fk_auth_user_id` (`history_user_id`),
  KEY `company_historicalbank_id_9e422782` (`id`),
  KEY `company_historicalbank_history_date_91e530ba` (`history_date`),
  KEY `company_historicalbank_company_id_3c8104af` (`company_id`),
  KEY `company_historicalbank_created_by_id_e15fb0d0` (`created_by_id`),
  KEY `company_historicalbank_updated_by_id_1493136b` (`updated_by_id`),
  CONSTRAINT `company_historicalbank_history_user_id_4c60ee67_fk_auth_user_id` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_historicalbank`
--

LOCK TABLES `company_historicalbank` WRITE;
/*!40000 ALTER TABLE `company_historicalbank` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_historicalbank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_historicalcompany`
--

DROP TABLE IF EXISTS `company_historicalcompany`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_historicalcompany` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `vat_id` varchar(50) NOT NULL,
  `court_register` varchar(50) DEFAULT NULL,
  `court` varchar(255) DEFAULT NULL,
  `street` varchar(255) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `city` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `phone_number` varchar(128) NOT NULL,
  `fax_number` varchar(128) DEFAULT NULL,
  `email` varchar(254) NOT NULL,
  `website` varchar(200) DEFAULT NULL,
  `logo` longtext DEFAULT NULL,
  `signature` longtext DEFAULT NULL,
  `prefix` varchar(5) DEFAULT NULL,
  `suffix` varchar(5) DEFAULT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `contact_person_id` bigint(20) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `company_historicalco_history_user_id_bce810c3_fk_auth_user` (`history_user_id`),
  KEY `company_historicalcompany_id_b8e7e50d` (`id`),
  KEY `company_historicalcompany_history_date_8f4bf421` (`history_date`),
  KEY `company_historicalcompany_contact_person_id_1d6f3fbe` (`contact_person_id`),
  KEY `company_historicalcompany_created_by_id_159d2301` (`created_by_id`),
  KEY `company_historicalcompany_updated_by_id_549d9f39` (`updated_by_id`),
  CONSTRAINT `company_historicalco_history_user_id_bce810c3_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_historicalcompany`
--

LOCK TABLES `company_historicalcompany` WRITE;
/*!40000 ALTER TABLE `company_historicalcompany` DISABLE KEYS */;
INSERT INTO `company_historicalcompany` VALUES (1,'2025-01-21 20:01:13.990589','2025-01-21 20:01:13.990618','IB Riesemann GmbH','DE259678911','HRB 22261','Amtsgericht Traunstein','Adelholzener Str. 34','83313','Siegsdorf','Deutschland','+4986624850000','+49866212455','info@ib-riesemann.de','https://www.ib-riesemann.com/','company/company_logos/IBR_Riesemann_GmbH_Logo_Uw2Dcqc.jpg','',NULL,NULL,1,'2025-01-21 20:01:13.993068',NULL,'+',NULL,1,1,1),(1,'2025-01-21 20:01:13.000000','2025-01-21 20:01:24.109068','IB Riesemann GmbH','DE259678911','HRB 22261','Amtsgericht Traunstein','Adelholzener Str. 34','83313','Siegsdorf','Deutschland','+4986624850000','+49866212455','info@ib-riesemann.de','https://www.ib-riesemann.com/','company/company_logos/IBR_Riesemann_GmbH_Logo_Uw2Dcqc.jpg','company/company_logos/signature_03lg01r.png',NULL,NULL,2,'2025-01-21 20:01:24.110611',NULL,'~',NULL,1,1,1),(1,'2025-01-21 20:01:13.000000','2025-01-21 20:02:06.148749','IB Riesemann GmbH','DE259678911','HRB 22261','Amtsgericht Traunstein','Adelholzener Str. 34','83313','Siegsdorf','Deutschland','+4986624850000','+49866212455','info@ib-riesemann.de','https://www.ib-riesemann.com/','company/company_logos/IBR_Riesemann_GmbH_Logo_Uw2Dcqc.jpg','company/company_logos/signature_03lg01r.png',NULL,NULL,3,'2025-01-21 20:02:06.150090',NULL,'~',1,1,1,1);
/*!40000 ALTER TABLE `company_historicalcompany` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_historicalcontact`
--

DROP TABLE IF EXISTS `company_historicalcontact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_historicalcontact` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `role` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone_number` varchar(128) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `company_historicalco_history_user_id_0f37dc95_fk_auth_user` (`history_user_id`),
  KEY `company_historicalcontact_id_50213bfd` (`id`),
  KEY `company_historicalcontact_history_date_97b7927c` (`history_date`),
  KEY `company_historicalcontact_created_by_id_9bda12cf` (`created_by_id`),
  KEY `company_historicalcontact_updated_by_id_510747a1` (`updated_by_id`),
  CONSTRAINT `company_historicalco_history_user_id_0f37dc95_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_historicalcontact`
--

LOCK TABLES `company_historicalcontact` WRITE;
/*!40000 ALTER TABLE `company_historicalcontact` DISABLE KEYS */;
INSERT INTO `company_historicalcontact` VALUES (1,'2025-01-21 20:01:56.023592','2025-01-21 20:01:56.023609','Dipl.-Ing.  Mathias','Riesemann B.Sc.','Geschäftsführer','info@ib-riesemann.de','+4986624850000',1,'2025-01-21 20:01:56.024395',NULL,'+',1,1,1);
/*!40000 ALTER TABLE `company_historicalcontact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_historicalordercounter`
--

DROP TABLE IF EXISTS `company_historicalordercounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_historicalordercounter` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `year` int(10) unsigned NOT NULL CHECK (`year` >= 0),
  `counter` int(10) unsigned NOT NULL CHECK (`counter` >= 0),
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `company_historicalor_history_user_id_74926a9c_fk_auth_user` (`history_user_id`),
  KEY `company_historicalordercounter_id_facd76a9` (`id`),
  KEY `company_historicalordercounter_history_date_d073a55f` (`history_date`),
  KEY `company_historicalordercounter_company_id_771c2189` (`company_id`),
  KEY `company_historicalordercounter_created_by_id_290dc47f` (`created_by_id`),
  KEY `company_historicalordercounter_updated_by_id_c663715d` (`updated_by_id`),
  CONSTRAINT `company_historicalor_history_user_id_74926a9c_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_historicalordercounter`
--

LOCK TABLES `company_historicalordercounter` WRITE;
/*!40000 ALTER TABLE `company_historicalordercounter` DISABLE KEYS */;
INSERT INTO `company_historicalordercounter` VALUES (1,'2025-01-21 20:09:49.350713','2025-01-21 20:09:49.350732',25,0,1,'2025-01-21 20:09:49.351401',NULL,'+',1,1,1,1),(1,'2025-01-21 20:09:49.350713','2025-01-21 21:19:26.246271',25,1,2,'2025-01-21 21:19:26.246922',NULL,'~',1,1,NULL,1);
/*!40000 ALTER TABLE `company_historicalordercounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_historicalsocialmedia`
--

DROP TABLE IF EXISTS `company_historicalsocialmedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_historicalsocialmedia` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `platform` varchar(100) NOT NULL,
  `url` varchar(200) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `company_historicalso_history_user_id_37f34145_fk_auth_user` (`history_user_id`),
  KEY `company_historicalsocialmedia_id_ae4e0fc5` (`id`),
  KEY `company_historicalsocialmedia_history_date_09c54d0f` (`history_date`),
  KEY `company_historicalsocialmedia_company_id_f306c975` (`company_id`),
  KEY `company_historicalsocialmedia_created_by_id_6bee4d55` (`created_by_id`),
  KEY `company_historicalsocialmedia_updated_by_id_2e877275` (`updated_by_id`),
  CONSTRAINT `company_historicalso_history_user_id_37f34145_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_historicalsocialmedia`
--

LOCK TABLES `company_historicalsocialmedia` WRITE;
/*!40000 ALTER TABLE `company_historicalsocialmedia` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_historicalsocialmedia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_ordercounter`
--

DROP TABLE IF EXISTS `company_ordercounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_ordercounter` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `year` int(10) unsigned NOT NULL CHECK (`year` >= 0),
  `counter` int(10) unsigned NOT NULL CHECK (`counter` >= 0),
  `company_id` bigint(20) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `company_ordercounter_company_id_year_66f1219b_uniq` (`company_id`,`year`),
  KEY `company_ordercounter_created_by_id_d5dae35f_fk_auth_user_id` (`created_by_id`),
  KEY `company_ordercounter_updated_by_id_94a0eb38_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `company_ordercounter_company_id_1d9bdd7b_fk_company_company_id` FOREIGN KEY (`company_id`) REFERENCES `company_company` (`id`),
  CONSTRAINT `company_ordercounter_created_by_id_d5dae35f_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `company_ordercounter_updated_by_id_94a0eb38_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_ordercounter`
--

LOCK TABLES `company_ordercounter` WRITE;
/*!40000 ALTER TABLE `company_ordercounter` DISABLE KEYS */;
INSERT INTO `company_ordercounter` VALUES (1,'2025-01-21 20:09:49.350713','2025-01-21 21:19:26.246271',25,1,1,1,1);
/*!40000 ALTER TABLE `company_ordercounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_socialmedia`
--

DROP TABLE IF EXISTS `company_socialmedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company_socialmedia` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `platform` varchar(100) NOT NULL,
  `url` varchar(200) NOT NULL,
  `company_id` bigint(20) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `company_socialmedia_company_id_41d611fd_fk_company_company_id` (`company_id`),
  KEY `company_socialmedia_created_by_id_cec958f6_fk_auth_user_id` (`created_by_id`),
  KEY `company_socialmedia_updated_by_id_6fbba86b_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `company_socialmedia_company_id_41d611fd_fk_company_company_id` FOREIGN KEY (`company_id`) REFERENCES `company_company` (`id`),
  CONSTRAINT `company_socialmedia_created_by_id_cec958f6_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `company_socialmedia_updated_by_id_6fbba86b_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_socialmedia`
--

LOCK TABLES `company_socialmedia` WRITE;
/*!40000 ALTER TABLE `company_socialmedia` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_socialmedia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers_customer`
--

DROP TABLE IF EXISTS `customers_customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers_customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `street` varchar(200) NOT NULL,
  `house_number` varchar(10) NOT NULL,
  `postal_code` varchar(10) NOT NULL,
  `city` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone` varchar(128) NOT NULL,
  `vat_id` varchar(20) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customers_customer_created_by_id_e3e9e010_fk_auth_user_id` (`created_by_id`),
  KEY `customers_customer_updated_by_id_c113ac83_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `customers_customer_created_by_id_e3e9e010_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `customers_customer_updated_by_id_c113ac83_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers_customer`
--

LOCK TABLES `customers_customer` WRITE;
/*!40000 ALTER TABLE `customers_customer` DISABLE KEYS */;
INSERT INTO `customers_customer` VALUES (1,'2025-01-21 21:17:49.873121','2025-01-21 21:17:49.873138','Sportverein Taching am See','Limberg','11','83373','Taching','Deutschland','teching@test.de','+49866397885',NULL,1,1),(2,'2025-02-19 14:35:10.153745','2025-02-19 14:35:10.153765','Straßer Franz Xaver','Karlsdorfer Str.','8b','85669','Pastetten','DE','strasserbrigitte@yahoo.de','+4986624850000',NULL,4,4),(3,'2025-02-20 12:33:19.388659','2025-02-20 12:33:19.388679','Gemeinde Siegsdorf','Rathausplatz','1','83313','Siegsdorf','Deutschland','wolfgang.geistanger@siegsdorf.bayern.de','+498662498711',NULL,4,4),(4,'2025-02-26 05:11:15.728988','2025-02-26 05:11:15.729005','Matthäus Utzinger e. K.','Murnau','1','84431','Rattenkirchen','Deutschland','m.utzinger@utzinger-holzbau.de','+498082308',NULL,4,4);
/*!40000 ALTER TABLE `customers_customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers_customercontact`
--

DROP TABLE IF EXISTS `customers_customercontact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers_customercontact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `customers_customercontact_created_by_id_36b6291b_fk_auth_user_id` (`created_by_id`),
  KEY `customers_customerco_customer_id_8ab9cff4_fk_customers` (`customer_id`),
  KEY `customers_customercontact_updated_by_id_2e904fc5_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `customers_customerco_customer_id_8ab9cff4_fk_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers_customer` (`id`),
  CONSTRAINT `customers_customercontact_created_by_id_36b6291b_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `customers_customercontact_updated_by_id_2e904fc5_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers_customercontact`
--

LOCK TABLES `customers_customercontact` WRITE;
/*!40000 ALTER TABLE `customers_customercontact` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers_customercontact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers_historicalcustomer`
--

DROP TABLE IF EXISTS `customers_historicalcustomer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers_historicalcustomer` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(200) NOT NULL,
  `street` varchar(200) NOT NULL,
  `house_number` varchar(10) NOT NULL,
  `postal_code` varchar(10) NOT NULL,
  `city` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `phone` varchar(128) NOT NULL,
  `vat_id` varchar(20) DEFAULT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `customers_historical_history_user_id_e2de29c6_fk_auth_user` (`history_user_id`),
  KEY `customers_historicalcustomer_id_b1265fea` (`id`),
  KEY `customers_historicalcustomer_history_date_60e2ef3b` (`history_date`),
  KEY `customers_historicalcustomer_created_by_id_e12d04fa` (`created_by_id`),
  KEY `customers_historicalcustomer_updated_by_id_102a631b` (`updated_by_id`),
  CONSTRAINT `customers_historical_history_user_id_e2de29c6_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers_historicalcustomer`
--

LOCK TABLES `customers_historicalcustomer` WRITE;
/*!40000 ALTER TABLE `customers_historicalcustomer` DISABLE KEYS */;
INSERT INTO `customers_historicalcustomer` VALUES (1,'2025-01-21 21:17:49.873121','2025-01-21 21:17:49.873138','Sportverein Taching am See','Limberg','11','83373','Taching','Deutschland','teching@test.de','+49866397885',NULL,1,'2025-01-21 21:17:49.873972',NULL,'+',1,1,1),(2,'2025-02-19 14:35:10.153745','2025-02-19 14:35:10.153765','Straßer Franz Xaver','Karlsdorfer Str.','8b','85669','Pastetten','DE','strasserbrigitte@yahoo.de','+4986624850000',NULL,2,'2025-02-19 14:35:10.154670',NULL,'+',4,4,4),(3,'2025-02-20 12:33:19.388659','2025-02-20 12:33:19.388679','Gemeinde Siegsdorf','Rathausplatz','1','83313','Siegsdorf','Deutschland','wolfgang.geistanger@siegsdorf.bayern.de','+498662498711',NULL,3,'2025-02-20 12:33:19.389523',NULL,'+',4,4,4),(4,'2025-02-26 05:11:15.728988','2025-02-26 05:11:15.729005','Matthäus Utzinger e. K.','Murnau','1','84431','Rattenkirchen','Deutschland','m.utzinger@utzinger-holzbau.de','+498082308',NULL,4,'2025-02-26 05:11:15.729844',NULL,'+',4,4,4);
/*!40000 ALTER TABLE `customers_historicalcustomer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers_historicalcustomercontact`
--

DROP TABLE IF EXISTS `customers_historicalcustomercontact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers_historicalcustomercontact` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `customers_historical_history_user_id_8628e93f_fk_auth_user` (`history_user_id`),
  KEY `customers_historicalcustomercontact_id_37175350` (`id`),
  KEY `customers_historicalcustomercontact_history_date_d9e45bd3` (`history_date`),
  KEY `customers_historicalcustomercontact_created_by_id_0eb3c5c3` (`created_by_id`),
  KEY `customers_historicalcustomercontact_customer_id_92182c44` (`customer_id`),
  KEY `customers_historicalcustomercontact_updated_by_id_13b2684a` (`updated_by_id`),
  CONSTRAINT `customers_historical_history_user_id_8628e93f_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers_historicalcustomercontact`
--

LOCK TABLES `customers_historicalcustomercontact` WRITE;
/*!40000 ALTER TABLE `customers_historicalcustomercontact` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers_historicalcustomercontact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2025-01-19 10:27:53.778030','1','get-company',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Email address\"]}}]',4,1),(2,'2025-01-21 20:01:13.996617','1','IB Riesemann GmbH',1,'[{\"added\": {}}]',38,1),(3,'2025-01-21 20:01:24.112774','1','IB Riesemann GmbH',2,'[{\"changed\": {\"fields\": [\"Unterschriftenbild\"]}}]',38,1),(4,'2025-01-21 20:01:56.026183','1','Dipl.-Ing.  Mathias Riesemann B.Sc. - Geschäftsführer',1,'[{\"added\": {}}]',42,1),(5,'2025-01-21 20:02:06.156923','1','IB Riesemann GmbH',2,'[{\"changed\": {\"fields\": [\"Ansprechpartner\"]}}]',38,1),(6,'2025-01-21 20:09:49.352869','1','OrderCounter object (1)',1,'[{\"added\": {}}]',40,1),(7,'2025-01-21 20:11:30.128470','1','Steuerfrei (0%)',1,'[{\"added\": {}}]',16,1),(8,'2025-01-21 20:11:53.365166','2','19% (19.0%)',1,'[{\"added\": {}}]',16,1),(9,'2025-01-21 20:12:36.793586','1','Architektur',1,'[{\"added\": {}}]',8,1),(10,'2025-01-21 20:12:50.459830','2','Tragwerksplanung',1,'[{\"added\": {}}]',8,1),(11,'2025-01-21 21:12:04.478468','1','Tragwerksplanung-LPH1 Grundlagenermittlung',1,'[{\"added\": {}}]',10,1),(12,'2025-01-21 21:12:25.142457','2','Tragwerksplanung-LPH2 Vorplanung',1,'[{\"added\": {}}]',10,1),(13,'2025-01-21 21:12:41.494431','3','Tragwerksplanung-LPH3 Entwurfsplanung',1,'[{\"added\": {}}]',10,1),(14,'2025-01-21 21:13:01.793961','4','Tragwerksplanung-LPH4 Genehmigungsplanung',1,'[{\"added\": {}}]',10,1),(15,'2025-01-21 21:13:19.815567','5','Tragwerksplanung-LPH5 Ausführungsplanung',1,'[{\"added\": {}}]',10,1),(16,'2025-01-21 21:13:37.145344','6','Tragwerksplanung-LPH6 Vorbereitung der Vergabe',1,'[{\"added\": {}}]',10,1),(17,'2025-01-21 21:13:58.530177','7','Architektur-LPH1 Grundlagenermittlung',1,'[{\"added\": {}}]',10,1),(18,'2025-01-21 21:14:20.434055','8','Architektur-LPH2 Vorplanung (Projekt- und Planungsvorbereitung)',1,'[{\"added\": {}}]',10,1),(19,'2025-01-21 21:14:40.825816','9','Architektur-LPH3 Entwurfsplanung (System- und Integrationsplanung)',1,'[{\"added\": {}}]',10,1),(20,'2025-01-21 21:15:05.084641','10','Architektur-LPH4 Genehmigungsplanung',1,'[{\"added\": {}}]',10,1),(21,'2025-01-21 21:15:22.822047','11','Architektur-LPH5 Ausführungsplanung',1,'[{\"added\": {}}]',10,1),(22,'2025-01-21 21:15:49.591710','12','Architektur-LPH6 Vorbereitung der Vergabe',1,'[{\"added\": {}}]',10,1),(23,'2025-01-21 21:16:07.689755','13','Architektur-LPH7 Mitwirkung bei der Vergabe',1,'[{\"added\": {}}]',10,1),(24,'2025-01-21 21:16:27.454914','14','Architektur-LPH8 Objektüberwachung (Bauüberwachung)',1,'[{\"added\": {}}]',10,1),(25,'2025-01-21 21:16:44.617286','15','Architektur-LPH9 Objektbetreuung und Dokumentation',1,'[{\"added\": {}}]',10,1),(26,'2025-01-21 21:17:49.875702','1','Sportverein Taching am See',1,'[{\"added\": {}}]',34,1),(27,'2025-01-21 21:19:26.257478','1','25-001 | Sportverein Taching am See',1,'[{\"added\": {}}, {\"added\": {\"name\": \"Projekt Honorargruppe\", \"object\": \"Testprojekt - Architektur\"}}, {\"added\": {\"name\": \"Projekt Honorargruppe\", \"object\": \"Testprojekt - Tragwerksplanung\"}}, {\"added\": {\"name\": \"Projekt Leistungsphase\", \"object\": \"LPH1\"}}]',18,1),(28,'2025-01-21 21:20:29.070102','1','25-001 | Sportverein Taching am See',2,'[]',18,1),(29,'2025-01-21 21:20:52.659448','1','25-001 | Sportverein Taching am See',2,'[]',18,1),(30,'2025-01-21 21:21:11.136561','7','Architektur-LPH1 Grundlagenermittlung',2,'[]',10,1),(31,'2025-01-21 21:21:13.411202','1','25-001 | Sportverein Taching am See',2,'[{\"changed\": {\"name\": \"Projekt Leistungsphase\", \"object\": \"LPH1\", \"fields\": [\"Prozentwert\"]}}]',18,1),(32,'2025-01-21 21:21:59.109966','1','Angebot',1,'[{\"added\": {}}]',12,1),(33,'2025-01-21 21:22:05.923427','1','Angebot für Projekt 25-001: Sportverein Taching am See',1,'[{\"added\": {}}]',14,1),(34,'2025-01-26 12:28:15.973734','2','n1kozor',1,'[{\"added\": {}}]',4,1),(35,'2025-01-26 12:28:32.316421','2','n1kozor',2,'[{\"changed\": {\"fields\": [\"Staff status\", \"Superuser status\"]}}]',4,1),(36,'2025-01-29 13:03:15.841414','1','Mitarbeiter',1,'[{\"added\": {}}]',3,1),(37,'2025-01-29 13:04:38.704189','3','kfeder',1,'[{\"added\": {}}]',4,1),(38,'2025-01-29 13:05:18.112995','3','kfeder',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Staff status\", \"Groups\"]}}]',4,1),(39,'2025-01-29 13:09:11.408781','4','riesemann',1,'[{\"added\": {}}]',4,1),(40,'2025-01-29 13:20:31.689872','4','riesemann',2,'[{\"changed\": {\"fields\": [\"First name\", \"Last name\", \"Email address\", \"Staff status\", \"Superuser status\"]}}]',4,1),(41,'2025-01-29 13:23:03.208036','4','riesemann',2,'[{\"changed\": {\"fields\": [\"Staff status\"]}}]',4,1),(42,'2025-01-29 13:23:12.200846','4','riesemann',2,'[{\"changed\": {\"fields\": [\"Staff status\"]}}]',4,1),(43,'2025-02-19 14:35:10.156368','2','Straßer Franz Xaver',1,'[{\"added\": {}}]',34,4),(44,'2025-02-19 14:38:30.141415','2','2025-22 | Straßer Franz Xaver',1,'[{\"added\": {}}, {\"added\": {\"name\": \"Besondere Leistungen\", \"object\": \"#1\"}}, {\"added\": {\"name\": \"Besondere Leistungen\", \"object\": \"#2\"}}, {\"added\": {\"name\": \"Besondere Leistungen\", \"object\": \"#3\"}}]',18,4),(45,'2025-02-19 14:39:08.369287','2','2025-22 | Straßer Franz Xaver',2,'[]',18,4),(46,'2025-02-19 14:39:10.083301','2','2025-22 | Straßer Franz Xaver',2,'[]',18,4),(47,'2025-02-19 14:39:14.057973','2','2025-22 | Straßer Franz Xaver',2,'[]',18,4),(48,'2025-02-19 14:39:35.222125','2','Angebot für Projekt 2025-22: Straßer Franz Xaver',1,'[{\"added\": {}}]',14,4),(49,'2025-02-19 14:41:53.222304','2','2025-22 | Straßer Franz Xaver',2,'[{\"changed\": {\"fields\": [\"Projektbezeichnung\"]}}]',18,4),(50,'2025-02-19 14:42:21.301863','2','2025-22 | Straßer Franz Xaver',2,'[{\"deleted\": {\"name\": \"Dokument\", \"object\": \"Angebot f\\u00fcr Projekt 2025-22: Stra\\u00dfer Franz Xaver\"}}]',18,4),(51,'2025-02-19 14:44:12.025840','2','2025-22 | Straßer Franz Xaver',2,'[{\"changed\": {\"name\": \"Besondere Leistungen\", \"object\": \"#3\", \"fields\": [\"Bezeichnung\"]}}]',18,4),(52,'2025-02-19 14:44:12.968940','2','2025-22 | Straßer Franz Xaver',2,'[]',18,4),(53,'2025-02-19 14:44:25.019655','3','Angebot für Projekt 2025-22: Straßer Franz Xaver',1,'[{\"added\": {}}]',14,4),(54,'2025-02-20 12:33:19.390969','3','Gemeinde Siegsdorf',1,'[{\"added\": {}}]',34,4),(55,'2025-02-20 12:33:56.422025','2','25-022 | Straßer Franz Xaver',2,'[{\"changed\": {\"fields\": [\"Auftragsnummer\"]}}]',18,4),(56,'2025-02-20 12:35:33.787745','3','24-055 | Gemeinde Siegsdorf',1,'[{\"added\": {}}, {\"added\": {\"name\": \"Projekt Honorargruppe\", \"object\": \"Feuerwehrhaus Vogling - Tragwerksplanung\"}}]',18,4),(57,'2025-02-20 12:37:36.143968','3','24-055 | Gemeinde Siegsdorf',2,'[{\"changed\": {\"fields\": [\"Nebenkosten (%)\"]}}]',18,4),(58,'2025-02-20 12:38:39.663417','3','24-055 | Gemeinde Siegsdorf',2,'[{\"added\": {\"name\": \"Projekt Leistungsphase\", \"object\": \"LPH4\"}}]',18,4),(59,'2025-02-20 12:39:07.943055','3','24-055 | Gemeinde Siegsdorf',2,'[{\"added\": {\"name\": \"Projekt Leistungsphase\", \"object\": \"LPH5\"}}, {\"changed\": {\"name\": \"Projekt Leistungsphase\", \"object\": \"LPH4\", \"fields\": [\"Rabatt (%)\"]}}]',18,4),(60,'2025-02-20 12:39:30.278566','3','24-055 | Gemeinde Siegsdorf',2,'[{\"changed\": {\"name\": \"Projekt Leistungsphase\", \"object\": \"LPH4\", \"fields\": [\"Prozentwert\"]}}, {\"changed\": {\"name\": \"Projekt Leistungsphase\", \"object\": \"LPH5\", \"fields\": [\"Prozentwert\"]}}]',18,4),(61,'2025-02-20 12:40:08.114997','3','24-055 | Gemeinde Siegsdorf',2,'[{\"changed\": {\"name\": \"Projekt Honorargruppe\", \"object\": \"Feuerwehrhaus Vogling - Tragwerksplanung\", \"fields\": [\"Honorarsumme (\\u20ac)\"]}}]',18,4),(62,'2025-02-20 12:42:02.120105','3','24-055 | Gemeinde Siegsdorf',2,'[{\"changed\": {\"name\": \"Projekt Honorargruppe\", \"object\": \"Feuerwehrhaus Vogling - Tragwerksplanung\", \"fields\": [\"Honorarsumme (\\u20ac)\"]}}]',18,4),(63,'2025-02-24 07:00:15.524169','2','n1kozor',3,'',4,1),(64,'2025-02-26 05:11:15.731625','4','Matthäus Utzinger e. K.',1,'[{\"added\": {}}]',34,4),(65,'2025-02-26 05:14:03.794600','4','2025-23 | Matthäus Utzinger e. K.',1,'[{\"added\": {}}]',18,4),(66,'2025-02-26 05:25:56.815230','4','2025-23 | Matthäus Utzinger e. K.',2,'[{\"changed\": {\"fields\": [\"Fahrtkosten (\\u20ac)\", \"Beschreibung (Intern)\"]}}, {\"added\": {\"name\": \"Besondere Leistungen\", \"object\": \"#1\"}}, {\"added\": {\"name\": \"Besondere Leistungen\", \"object\": \"#2\"}}]',18,4),(67,'2025-02-26 05:26:25.002640','4','Angebot für Projekt 2025-23: Matthäus Utzinger e. K.',1,'[{\"added\": {}}]',14,4),(68,'2025-02-26 05:27:31.432252','4','Angebot für Projekt 2025-23: Matthäus Utzinger e. K.',2,'[{\"changed\": {\"fields\": [\"Beschreibung\", \"Abschluss\"]}}]',14,4);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(44,'company','bank'),(38,'company','company'),(42,'company','contact'),(43,'company','historicalbank'),(37,'company','historicalcompany'),(41,'company','historicalcontact'),(39,'company','historicalordercounter'),(45,'company','historicalsocialmedia'),(40,'company','ordercounter'),(46,'company','socialmedia'),(5,'contenttypes','contenttype'),(34,'customers','customer'),(36,'customers','customercontact'),(33,'customers','historicalcustomer'),(35,'customers','historicalcustomercontact'),(14,'orders','document'),(12,'orders','documenttype'),(8,'orders','feegroup'),(26,'orders','flatfee'),(13,'orders','historicaldocument'),(11,'orders','historicaldocumenttype'),(7,'orders','historicalfeegroup'),(25,'orders','historicalflatfee'),(17,'orders','historicalorder'),(23,'orders','historicalorderfeegroup'),(19,'orders','historicalorderlineitem'),(21,'orders','historicalorderservicephase'),(9,'orders','historicalservicephase'),(31,'orders','historicaltag'),(27,'orders','historicaltask'),(29,'orders','historicaltaskposition'),(15,'orders','historicalvat'),(18,'orders','order'),(24,'orders','orderfeegroup'),(20,'orders','orderlineitem'),(22,'orders','orderservicephase'),(10,'orders','servicephase'),(32,'orders','tag'),(28,'orders','task'),(30,'orders','taskposition'),(16,'orders','vat'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-01-17 19:41:51.929461'),(2,'auth','0001_initial','2025-01-17 19:41:52.009945'),(3,'admin','0001_initial','2025-01-17 19:41:52.034111'),(4,'admin','0002_logentry_remove_auto_add','2025-01-17 19:41:52.044154'),(5,'admin','0003_logentry_add_action_flag_choices','2025-01-17 19:41:52.052807'),(6,'contenttypes','0002_remove_content_type_name','2025-01-17 19:41:52.139226'),(7,'auth','0002_alter_permission_name_max_length','2025-01-17 19:41:52.155882'),(8,'auth','0003_alter_user_email_max_length','2025-01-17 19:41:52.169123'),(9,'auth','0004_alter_user_username_opts','2025-01-17 19:41:52.177732'),(10,'auth','0005_alter_user_last_login_null','2025-01-17 19:41:52.193384'),(11,'auth','0006_require_contenttypes_0002','2025-01-17 19:41:52.194255'),(12,'auth','0007_alter_validators_add_error_messages','2025-01-17 19:41:52.202791'),(13,'auth','0008_alter_user_username_max_length','2025-01-17 19:41:52.221888'),(14,'auth','0009_alter_user_last_name_max_length','2025-01-17 19:41:52.294335'),(15,'auth','0010_alter_group_name_max_length','2025-01-17 19:41:52.309313'),(16,'auth','0011_update_proxy_permissions','2025-01-17 19:41:52.366390'),(17,'auth','0012_alter_user_first_name_max_length','2025-01-17 19:41:52.377307'),(18,'sessions','0001_initial','2025-01-17 19:41:52.384507'),(19,'company','0001_initial','2025-01-19 11:16:48.621581'),(20,'customers','0001_initial','2025-01-19 11:16:50.523536'),(21,'orders','0001_initial','2025-01-19 11:17:06.363606');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('4s617klckjdup44z240w7r6863dx18ru','.eJxVjEEOwiAQRe_C2pBCKdO6dN8zkAFmpGogKe3KeHdp0oVu33v_v4XDfUtur7S6JYqrMOLyyzyGJ-VDxAfme5Gh5G1dvDwSedoq5xLpdTvbv4OENbX1RBqiUcYQBxsURjY4AAQYLPpeK4gd9NYzNw7AHU1-tD0yjFY3A-LzBfMrN-k:1tkl35:9UWJiDCGG0nSixJxf3bmtjmcYE2-r3DS_VIdJN8qsmI','2025-03-05 14:27:39.332546'),('5xbe6bk0w32wyidvz5v1sawh51e26f62','.eJxVjEEOwiAQRe_C2pAW6AAu3XuGZmaYStVAUtqV8e7apAvd_vfef6kRtzWPW5NlnJM6q16dfjdCfkjZQbpjuVXNtazLTHpX9EGbvtYkz8vh_h1kbPlbs-2ngM6BYxCINpBQ7AIOBmJkAY9g_IB9IBRmnDzajiDFNLAYtpN6fwDopDif:1tc1ie:pp9HuyZ3Iimi1LpRjn-hMhFnbA8bWnD7yBM36Q8J1II','2025-02-09 12:26:28.667599'),('hynuspdxkw4cac5lyk3z1b4u0v4u4cq7','.eJxVjEEOwiAQRe_C2pAW6AAu3XuGZmaYStVAUtqV8e7apAvd_vfef6kRtzWPW5NlnJM6q16dfjdCfkjZQbpjuVXNtazLTHpX9EGbvtYkz8vh_h1kbPlbs-2ngM6BYxCINpBQ7AIOBmJkAY9g_IB9IBRmnDzajiDFNLAYtpN6fwDopDif:1taLq8:3VvUb8WzDWTwrLQemoOok7qpww65-PNHqSj0PLI_6lc','2025-02-04 21:31:16.248608'),('mjjstbqu358jb2juv4ape6wb3u1b6mqa','.eJxVjEEOwiAQRe_C2pAW6AAu3XuGZmaYStVAUtqV8e7apAvd_vfef6kRtzWPW5NlnJM6q16dfjdCfkjZQbpjuVXNtazLTHpX9EGbvtYkz8vh_h1kbPlbs-2ngM6BYxCINpBQ7AIOBmJkAY9g_IB9IBRmnDzajiDFNLAYtpN6fwDopDif:1tYsGx:ukWBsJzHf71OJFBdI8NIUOoOOhIc7JkrppRPWnEIQ2M','2025-01-31 19:44:51.177318'),('n37yk11x3zpmr39y16o1cgqcpe8gvbr9','.eJxVjEEOwiAQRe_C2pBCKdO6dN8zkAFmpGogKe3KeHdp0oVu33v_v4XDfUtur7S6JYqrMOLyyzyGJ-VDxAfme5Gh5G1dvDwSedoq5xLpdTvbv4OENbX1RBqiUcYQBxsURjY4AAQYLPpeK4gd9NYzNw7AHU1-tD0yjFY3A-LzBfMrN-k:1tklFz:tFrgrJVhCglbW0EguTDrv87SpAT5OXItwhdcSoerw2U','2025-03-05 14:40:59.477435'),('opjm4y5czz3xenh53hnpc94uojgcekk0','.eJxVjEEOwiAQRe_C2pBCKdO6dN8zkAFmpGogKe3KeHdp0oVu33v_v4XDfUtur7S6JYqrMOLyyzyGJ-VDxAfme5Gh5G1dvDwSedoq5xLpdTvbv4OENbX1RBqiUcYQBxsURjY4AAQYLPpeK4gd9NYzNw7AHU1-tD0yjFY3A-LzBfMrN-k:1tn9fO:IAIAITAJfPos16LO6JNbNWQqQJkY87tB7SY0CLF2P-M','2025-03-12 05:09:06.030027'),('pcuslcj7pvx9artm7zbzvidupn0exnu0','.eJxVjMEOwiAQRP-FsyHAYqE9evcbyMKubbUpCdCT8d9tkx70ODNv3lsE3NoUtsolzCQGYcTlt4uYXrweAz1xHbNMeW1ljvJA5LlWec_Ey-1k_wQT1ml_d946R0YDJW876JXqUQNHcP5hwTOnPXdso_VsUJNyeNVWe4LkFBi1S1sex4VDnYkjFjG0svHnC85VPwE:1tc1l4:o_Ht0oPcpMcMvMd2QHzjwomzu9L0L4QNTp29uat7csc','2025-02-09 12:28:58.738825'),('vi5au9hpcqtl4cion24ts4tgj7xfdyaw','.eJxVjEEOwiAQRe_C2pAW6AAu3XuGZmaYStVAUtqV8e7apAvd_vfef6kRtzWPW5NlnJM6q16dfjdCfkjZQbpjuVXNtazLTHpX9EGbvtYkz8vh_h1kbPlbs-2ngM6BYxCINpBQ7AIOBmJkAY9g_IB9IBRmnDzajiDFNLAYtpN6fwDopDif:1tZ4cw:AQAwpgokmrqQecLz1qOtgUSqfAvrAACyiw3YN6E-1N4','2025-02-01 08:56:22.982860'),('z9s5e10zpq7vpsck0vf74is3axv78pi1','.eJxVjDsOwjAQBe_iGlne4KwNJX3OYL31GhxAiZRPhbg7REoB7ZuZ9zIJ61LTOpcp9WrOhszhdxPkRxk2oHcMt9HmcVimXuym2J3Othu1PC-7-3dQMddvzaJM3KonRFCAExw9Ea5eKaNxsTlRbBAQs28Z2ipECvui7FgQzPsD4i44Ow:1ucTlG:W_2d0Un3zzbKMM5wbGIpKMa8EtIuza-wJO_4HrlOuZU','2025-07-31 18:55:18.950131');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_document`
--

DROP TABLE IF EXISTS `orders_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_document` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `file_path` varchar(100) DEFAULT NULL,
  `introduction` longtext DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `conclusion` longtext DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `document_type_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_document_order_id_f40457bc_fk_orders_order_id` (`order_id`),
  KEY `orders_document_created_by_id_d9a53ba0_fk_auth_user_id` (`created_by_id`),
  KEY `orders_document_updated_by_id_7a50c551_fk_auth_user_id` (`updated_by_id`),
  KEY `orders_document_document_type_id_b3a81eec_fk_orders_do` (`document_type_id`),
  CONSTRAINT `orders_document_created_by_id_d9a53ba0_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `orders_document_document_type_id_b3a81eec_fk_orders_do` FOREIGN KEY (`document_type_id`) REFERENCES `orders_documenttype` (`id`),
  CONSTRAINT `orders_document_order_id_f40457bc_fk_orders_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`id`),
  CONSTRAINT `orders_document_updated_by_id_7a50c551_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_document`
--

LOCK TABLES `orders_document` WRITE;
/*!40000 ALTER TABLE `orders_document` DISABLE KEYS */;
INSERT INTO `orders_document` VALUES (1,'2025-01-21 21:22:05.916777','2025-01-26 12:30:24.186886','documents/2025/Angebot/25-001-Angebot-2025-01-26.pdf','<p>{% if contact %} {{ contact.name }} {% else %} Sehr geehrte Damen und Herren, {% endif %} zu o.g. Bauvorhaben m&ouml;chte ich Ihnen gerne folgendes Angebot unterbreiten.</p>','','',1,1,1,1),(3,'2025-02-19 14:44:25.012520','2025-02-19 14:44:27.390621','documents/2025/Angebot/2025-22-Angebot-2025-02-19.pdf','<p>{% if contact %} {{ contact.name }} {% else %} Sehr geehrte Damen und Herren, {% endif %} zu o.g. Bauvorhaben m&ouml;chte ich Ihnen gerne folgendes Angebot unterbreiten.</p>','','',4,4,1,2),(4,'2025-02-26 05:26:24.000000','2025-02-26 05:27:35.371156','documents/2025/Angebot/2025-23-Angebot-2025-02-26.pdf','<p>{% if contact %} {{ contact.name }} {% else %} Sehr geehrte Damen und Herren, {% endif %} zu o.g. Bauvorhaben m&ouml;chte ich Ihnen gerne folgendes Angebot unterbreiten.</p>','<p>Garage Kunzmann</p>','<p><span style=\"font-size: 11.0pt; mso-bidi-font-size: 12.0pt; line-height: 120%; font-family: \'Arial\',sans-serif; mso-fareast-font-family: \'MS Mincho\'; mso-bidi-font-family: \'Times New Roman\'; mso-ansi-language: DE; mso-fareast-language: JA; mso-bidi-language: AR-SA;\">Annahme: Die Statik ist nicht pr&uuml;fpflichtig und eine Flachgr&uuml;ndung ist m&ouml;glich. Bei &Auml;nderungen des Entwurfes und Vor-Ort-Terminen wird zus&auml;tzlicher Zeitaufwand nach Stunden (95,00&euro;/h netto +0,50&euro;/km) abgerechnet. Eine Bewehrungsabnahme ist nicht mit in dem Preis inbegriffen.</span></p>',4,4,1,4);
/*!40000 ALTER TABLE `orders_document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_documenttype`
--

DROP TABLE IF EXISTS `orders_documenttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_documenttype` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `book_tasks` tinyint(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_documenttype_created_by_id_f4fcc51a_fk_auth_user_id` (`created_by_id`),
  KEY `orders_documenttype_updated_by_id_b42bb864_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `orders_documenttype_created_by_id_f4fcc51a_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `orders_documenttype_updated_by_id_b42bb864_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_documenttype`
--

LOCK TABLES `orders_documenttype` WRITE;
/*!40000 ALTER TABLE `orders_documenttype` DISABLE KEYS */;
INSERT INTO `orders_documenttype` VALUES (1,'2025-01-21 21:21:59.107854','2025-01-21 21:21:59.107872','Angebot','',0,1,1);
/*!40000 ALTER TABLE `orders_documenttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_feegroup`
--

DROP TABLE IF EXISTS `orders_feegroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_feegroup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_feegroup_created_by_id_27b9dab6_fk_auth_user_id` (`created_by_id`),
  KEY `orders_feegroup_updated_by_id_837a271f_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `orders_feegroup_created_by_id_27b9dab6_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `orders_feegroup_updated_by_id_837a271f_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_feegroup`
--

LOCK TABLES `orders_feegroup` WRITE;
/*!40000 ALTER TABLE `orders_feegroup` DISABLE KEYS */;
INSERT INTO `orders_feegroup` VALUES (1,'2025-01-21 20:12:36.791465','2025-01-21 20:12:36.791482','Architektur',1,1),(2,'2025-01-21 20:12:50.456736','2025-01-21 20:12:50.456757','Tragwerksplanung',1,1);
/*!40000 ALTER TABLE `orders_feegroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_flatfee`
--

DROP TABLE IF EXISTS `orders_flatfee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_flatfee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` longtext NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `order_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_flatfee_created_by_id_1ad3ebed_fk_auth_user_id` (`created_by_id`),
  KEY `orders_flatfee_updated_by_id_e4886eed_fk_auth_user_id` (`updated_by_id`),
  KEY `orders_flatfee_order_id_d167f761_fk_orders_order_id` (`order_id`),
  CONSTRAINT `orders_flatfee_created_by_id_1ad3ebed_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `orders_flatfee_order_id_d167f761_fk_orders_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`id`),
  CONSTRAINT `orders_flatfee_updated_by_id_e4886eed_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_flatfee`
--

LOCK TABLES `orders_flatfee` WRITE;
/*!40000 ALTER TABLE `orders_flatfee` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_flatfee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_historicaldocument`
--

DROP TABLE IF EXISTS `orders_historicaldocument`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_historicaldocument` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `file_path` longtext DEFAULT NULL,
  `introduction` longtext DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `conclusion` longtext DEFAULT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `document_type_id` bigint(20) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `orders_historicaldoc_history_user_id_8cb0dec6_fk_auth_user` (`history_user_id`),
  KEY `orders_historicaldocument_id_11523d0c` (`id`),
  KEY `orders_historicaldocument_history_date_086528e3` (`history_date`),
  KEY `orders_historicaldocument_created_by_id_748a8460` (`created_by_id`),
  KEY `orders_historicaldocument_document_type_id_d5b8037e` (`document_type_id`),
  KEY `orders_historicaldocument_updated_by_id_51816182` (`updated_by_id`),
  KEY `orders_historicaldocument_order_id_82d73f27` (`order_id`),
  CONSTRAINT `orders_historicaldoc_history_user_id_8cb0dec6_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_historicaldocument`
--

LOCK TABLES `orders_historicaldocument` WRITE;
/*!40000 ALTER TABLE `orders_historicaldocument` DISABLE KEYS */;
INSERT INTO `orders_historicaldocument` VALUES (1,'2025-01-21 21:22:05.916777','2025-01-21 21:22:05.916803','','<p>{% if contact %} {{ contact.name }} {% else %} Sehr geehrte Damen und Herren, {% endif %} zu o.g. Bauvorhaben m&ouml;chte ich Ihnen gerne folgendes Angebot unterbreiten.</p>','','',1,'2025-01-21 21:22:05.917687',NULL,'+',1,1,1,1,1),(1,'2025-01-21 21:22:05.916777','2025-01-21 21:40:22.166318','documents/2025/Angebot/25-001-Angebot-2025-01-21.pdf','<p>{% if contact %} {{ contact.name }} {% else %} Sehr geehrte Damen und Herren, {% endif %} zu o.g. Bauvorhaben m&ouml;chte ich Ihnen gerne folgendes Angebot unterbreiten.</p>','','',2,'2025-01-21 21:40:22.168319',NULL,'~',1,1,NULL,1,1),(1,'2025-01-21 21:22:05.916777','2025-01-26 12:30:24.186886','documents/2025/Angebot/25-001-Angebot-2025-01-26.pdf','<p>{% if contact %} {{ contact.name }} {% else %} Sehr geehrte Damen und Herren, {% endif %} zu o.g. Bauvorhaben m&ouml;chte ich Ihnen gerne folgendes Angebot unterbreiten.</p>','','',3,'2025-01-26 12:30:24.188115',NULL,'~',1,1,NULL,1,1),(2,'2025-02-19 14:39:35.216704','2025-02-19 14:39:35.216722','','<p>{% if contact %} {{ contact.name }} {% else %} Sehr geehrte Damen und Herren, {% endif %} zu o.g. Bauvorhaben m&ouml;chte ich Ihnen gerne folgendes Angebot unterbreiten.</p>','','',4,'2025-02-19 14:39:35.217653',NULL,'+',4,1,4,4,2),(2,'2025-02-19 14:39:35.216704','2025-02-19 14:39:56.148976','documents/2025/Angebot/2025-22-Angebot-2025-02-19.pdf','<p>{% if contact %} {{ contact.name }} {% else %} Sehr geehrte Damen und Herren, {% endif %} zu o.g. Bauvorhaben m&ouml;chte ich Ihnen gerne folgendes Angebot unterbreiten.</p>','','',5,'2025-02-19 14:39:56.150161',NULL,'~',4,1,NULL,4,2),(2,'2025-02-19 14:39:35.216704','2025-02-19 14:39:56.148976','documents/2025/Angebot/2025-22-Angebot-2025-02-19.pdf','<p>{% if contact %} {{ contact.name }} {% else %} Sehr geehrte Damen und Herren, {% endif %} zu o.g. Bauvorhaben m&ouml;chte ich Ihnen gerne folgendes Angebot unterbreiten.</p>','','',6,'2025-02-19 14:42:21.300099',NULL,'-',4,1,4,4,2),(3,'2025-02-19 14:44:25.012520','2025-02-19 14:44:25.012557','','<p>{% if contact %} {{ contact.name }} {% else %} Sehr geehrte Damen und Herren, {% endif %} zu o.g. Bauvorhaben m&ouml;chte ich Ihnen gerne folgendes Angebot unterbreiten.</p>','','',7,'2025-02-19 14:44:25.013511',NULL,'+',4,1,4,4,2),(3,'2025-02-19 14:44:25.012520','2025-02-19 14:44:27.390621','documents/2025/Angebot/2025-22-Angebot-2025-02-19.pdf','<p>{% if contact %} {{ contact.name }} {% else %} Sehr geehrte Damen und Herren, {% endif %} zu o.g. Bauvorhaben m&ouml;chte ich Ihnen gerne folgendes Angebot unterbreiten.</p>','','',8,'2025-02-19 14:44:27.391863',NULL,'~',4,1,NULL,4,2),(4,'2025-02-26 05:26:24.997394','2025-02-26 05:26:24.997412','','<p>{% if contact %} {{ contact.name }} {% else %} Sehr geehrte Damen und Herren, {% endif %} zu o.g. Bauvorhaben m&ouml;chte ich Ihnen gerne folgendes Angebot unterbreiten.</p>','','',9,'2025-02-26 05:26:24.997987',NULL,'+',4,1,4,4,4),(4,'2025-02-26 05:26:24.000000','2025-02-26 05:27:31.427338','','<p>{% if contact %} {{ contact.name }} {% else %} Sehr geehrte Damen und Herren, {% endif %} zu o.g. Bauvorhaben m&ouml;chte ich Ihnen gerne folgendes Angebot unterbreiten.</p>','<p>Garage Kunzmann</p>','<p><span style=\"font-size: 11.0pt; mso-bidi-font-size: 12.0pt; line-height: 120%; font-family: \'Arial\',sans-serif; mso-fareast-font-family: \'MS Mincho\'; mso-bidi-font-family: \'Times New Roman\'; mso-ansi-language: DE; mso-fareast-language: JA; mso-bidi-language: AR-SA;\">Annahme: Die Statik ist nicht pr&uuml;fpflichtig und eine Flachgr&uuml;ndung ist m&ouml;glich. Bei &Auml;nderungen des Entwurfes und Vor-Ort-Terminen wird zus&auml;tzlicher Zeitaufwand nach Stunden (95,00&euro;/h netto +0,50&euro;/km) abgerechnet. Eine Bewehrungsabnahme ist nicht mit in dem Preis inbegriffen.</span></p>',10,'2025-02-26 05:27:31.428105',NULL,'~',4,1,4,4,4),(4,'2025-02-26 05:26:24.000000','2025-02-26 05:27:35.371156','documents/2025/Angebot/2025-23-Angebot-2025-02-26.pdf','<p>{% if contact %} {{ contact.name }} {% else %} Sehr geehrte Damen und Herren, {% endif %} zu o.g. Bauvorhaben m&ouml;chte ich Ihnen gerne folgendes Angebot unterbreiten.</p>','<p>Garage Kunzmann</p>','<p><span style=\"font-size: 11.0pt; mso-bidi-font-size: 12.0pt; line-height: 120%; font-family: \'Arial\',sans-serif; mso-fareast-font-family: \'MS Mincho\'; mso-bidi-font-family: \'Times New Roman\'; mso-ansi-language: DE; mso-fareast-language: JA; mso-bidi-language: AR-SA;\">Annahme: Die Statik ist nicht pr&uuml;fpflichtig und eine Flachgr&uuml;ndung ist m&ouml;glich. Bei &Auml;nderungen des Entwurfes und Vor-Ort-Terminen wird zus&auml;tzlicher Zeitaufwand nach Stunden (95,00&euro;/h netto +0,50&euro;/km) abgerechnet. Eine Bewehrungsabnahme ist nicht mit in dem Preis inbegriffen.</span></p>',11,'2025-02-26 05:27:35.372518',NULL,'~',4,1,NULL,4,4);
/*!40000 ALTER TABLE `orders_historicaldocument` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_historicaldocumenttype`
--

DROP TABLE IF EXISTS `orders_historicaldocumenttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_historicaldocumenttype` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `book_tasks` tinyint(1) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `orders_historicaldoc_history_user_id_5335f7aa_fk_auth_user` (`history_user_id`),
  KEY `orders_historicaldocumenttype_id_0f040d71` (`id`),
  KEY `orders_historicaldocumenttype_history_date_23948d26` (`history_date`),
  KEY `orders_historicaldocumenttype_created_by_id_87d39ff3` (`created_by_id`),
  KEY `orders_historicaldocumenttype_updated_by_id_49c34b60` (`updated_by_id`),
  CONSTRAINT `orders_historicaldoc_history_user_id_5335f7aa_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_historicaldocumenttype`
--

LOCK TABLES `orders_historicaldocumenttype` WRITE;
/*!40000 ALTER TABLE `orders_historicaldocumenttype` DISABLE KEYS */;
INSERT INTO `orders_historicaldocumenttype` VALUES (1,'2025-01-21 21:21:59.107854','2025-01-21 21:21:59.107872','Angebot','',0,1,'2025-01-21 21:21:59.108557',NULL,'+',1,1,1);
/*!40000 ALTER TABLE `orders_historicaldocumenttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_historicalfeegroup`
--

DROP TABLE IF EXISTS `orders_historicalfeegroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_historicalfeegroup` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `orders_historicalfee_history_user_id_b33c6fb2_fk_auth_user` (`history_user_id`),
  KEY `orders_historicalfeegroup_id_7bf79af3` (`id`),
  KEY `orders_historicalfeegroup_history_date_dba0fdd2` (`history_date`),
  KEY `orders_historicalfeegroup_created_by_id_232c7c66` (`created_by_id`),
  KEY `orders_historicalfeegroup_updated_by_id_6cdcc430` (`updated_by_id`),
  CONSTRAINT `orders_historicalfee_history_user_id_b33c6fb2_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_historicalfeegroup`
--

LOCK TABLES `orders_historicalfeegroup` WRITE;
/*!40000 ALTER TABLE `orders_historicalfeegroup` DISABLE KEYS */;
INSERT INTO `orders_historicalfeegroup` VALUES (1,'2025-01-21 20:12:36.791465','2025-01-21 20:12:36.791482','Architektur',1,'2025-01-21 20:12:36.792179',NULL,'+',1,1,1),(2,'2025-01-21 20:12:50.456736','2025-01-21 20:12:50.456757','Tragwerksplanung',2,'2025-01-21 20:12:50.457835',NULL,'+',1,1,1);
/*!40000 ALTER TABLE `orders_historicalfeegroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_historicalflatfee`
--

DROP TABLE IF EXISTS `orders_historicalflatfee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_historicalflatfee` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` longtext NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `orders_historicalfla_history_user_id_4dac30c4_fk_auth_user` (`history_user_id`),
  KEY `orders_historicalflatfee_id_99b406ed` (`id`),
  KEY `orders_historicalflatfee_history_date_46e90c9f` (`history_date`),
  KEY `orders_historicalflatfee_created_by_id_3c3e46c1` (`created_by_id`),
  KEY `orders_historicalflatfee_updated_by_id_0dd8f70b` (`updated_by_id`),
  KEY `orders_historicalflatfee_order_id_abe67f6b` (`order_id`),
  CONSTRAINT `orders_historicalfla_history_user_id_4dac30c4_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_historicalflatfee`
--

LOCK TABLES `orders_historicalflatfee` WRITE;
/*!40000 ALTER TABLE `orders_historicalflatfee` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_historicalflatfee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_historicalorder`
--

DROP TABLE IF EXISTS `orders_historicalorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_historicalorder` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `nr` varchar(10) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `hourly_rate` decimal(6,2) DEFAULT NULL,
  `flat_rate` decimal(10,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `additional_costs` decimal(5,2) DEFAULT NULL,
  `km_cost` decimal(5,2) DEFAULT NULL,
  `km` decimal(12,2) DEFAULT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `company_id` bigint(20) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `customer_id` bigint(20) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `vat_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `orders_historicalorder_history_user_id_30fb2c8b_fk_auth_user_id` (`history_user_id`),
  KEY `orders_historicalorder_id_91eda5cd` (`id`),
  KEY `orders_historicalorder_nr_cb81a039` (`nr`),
  KEY `orders_historicalorder_history_date_d905f9c2` (`history_date`),
  KEY `orders_historicalorder_company_id_cf27da70` (`company_id`),
  KEY `orders_historicalorder_created_by_id_52103841` (`created_by_id`),
  KEY `orders_historicalorder_customer_id_8a49c783` (`customer_id`),
  KEY `orders_historicalorder_updated_by_id_66d06d1f` (`updated_by_id`),
  KEY `orders_historicalorder_vat_id_d6081945` (`vat_id`),
  CONSTRAINT `orders_historicalorder_history_user_id_30fb2c8b_fk_auth_user_id` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_historicalorder`
--

LOCK TABLES `orders_historicalorder` WRITE;
/*!40000 ALTER TABLE `orders_historicalorder` DISABLE KEYS */;
INSERT INTO `orders_historicalorder` VALUES (1,'2025-01-21 21:19:26.245205','2025-01-21 21:19:26.245224','Testprojekt','25-001','',85.00,NULL,NULL,NULL,5.00,0.00,0.00,1,'2025-01-21 21:19:26.249377',NULL,'+',1,1,1,1,1,2),(1,'2025-01-21 21:19:26.245205','2025-01-21 21:20:29.067587','Testprojekt','25-001','',85.00,NULL,NULL,NULL,5.00,0.00,0.00,2,'2025-01-21 21:20:29.068601',NULL,'~',1,1,1,1,1,2),(1,'2025-01-21 21:19:26.245205','2025-01-21 21:20:52.657164','Testprojekt','25-001','',85.00,NULL,NULL,NULL,5.00,0.00,0.00,3,'2025-01-21 21:20:52.657984',NULL,'~',1,1,1,1,1,2),(1,'2025-01-21 21:19:26.245205','2025-01-21 21:21:13.403164','Testprojekt','25-001','',85.00,NULL,NULL,NULL,5.00,0.00,0.00,4,'2025-01-21 21:21:13.404332',NULL,'~',1,1,1,1,1,2),(2,'2025-02-19 14:38:30.129794','2025-02-19 14:38:30.129815',NULL,'2025-22','',95.00,NULL,NULL,NULL,5.00,0.00,0.00,5,'2025-02-19 14:38:30.130651',NULL,'+',1,4,2,4,4,2),(2,'2025-02-19 14:38:30.129794','2025-02-19 14:39:08.366294',NULL,'2025-22','',95.00,NULL,NULL,NULL,5.00,0.00,0.00,6,'2025-02-19 14:39:08.367212',NULL,'~',1,4,2,4,4,2),(2,'2025-02-19 14:38:30.129794','2025-02-19 14:39:10.080844',NULL,'2025-22','',95.00,NULL,NULL,NULL,5.00,0.00,0.00,7,'2025-02-19 14:39:10.081770',NULL,'~',1,4,2,4,4,2),(2,'2025-02-19 14:38:30.129794','2025-02-19 14:39:14.055769',NULL,'2025-22','',95.00,NULL,NULL,NULL,5.00,0.00,0.00,8,'2025-02-19 14:39:14.056594',NULL,'~',1,4,2,4,4,2),(2,'2025-02-19 14:38:30.129794','2025-02-19 14:41:53.219658','Neubau eines Geräteschuppens','2025-22','',95.00,NULL,NULL,NULL,5.00,0.00,0.00,9,'2025-02-19 14:41:53.220650',NULL,'~',1,4,2,4,4,2),(2,'2025-02-19 14:38:30.129794','2025-02-19 14:42:21.295061','Neubau eines Geräteschuppens','2025-22','',95.00,NULL,NULL,NULL,5.00,0.00,0.00,10,'2025-02-19 14:42:21.295891',NULL,'~',1,4,2,4,4,2),(2,'2025-02-19 14:38:30.129794','2025-02-19 14:44:12.014726','Neubau eines Geräteschuppens','2025-22','',95.00,NULL,NULL,NULL,5.00,0.00,0.00,11,'2025-02-19 14:44:12.018253',NULL,'~',1,4,2,4,4,2),(2,'2025-02-19 14:38:30.129794','2025-02-19 14:44:12.966036','Neubau eines Geräteschuppens','2025-22','',95.00,NULL,NULL,NULL,5.00,0.00,0.00,12,'2025-02-19 14:44:12.967058',NULL,'~',1,4,2,4,4,2),(2,'2025-02-19 14:38:30.129794','2025-02-20 12:33:56.419533','Neubau eines Geräteschuppens','25-022','',95.00,NULL,NULL,NULL,5.00,0.00,0.00,13,'2025-02-20 12:33:56.420377',NULL,'~',1,4,2,4,4,2),(3,'2025-02-20 12:35:33.782925','2025-02-20 12:35:33.782945','Feuerwehrhaus Vogling','24-055','',95.00,NULL,NULL,NULL,5.00,0.00,0.00,14,'2025-02-20 12:35:33.783649',NULL,'+',1,4,3,4,4,NULL),(3,'2025-02-20 12:35:33.782925','2025-02-20 12:37:36.141766','Feuerwehrhaus Vogling','24-055','',95.00,NULL,NULL,NULL,2.00,0.00,0.00,16,'2025-02-20 12:37:36.142559',NULL,'~',1,4,3,4,4,NULL),(3,'2025-02-20 12:35:33.782925','2025-02-20 12:38:39.657789','Feuerwehrhaus Vogling','24-055','',95.00,NULL,NULL,NULL,2.00,0.00,0.00,18,'2025-02-20 12:38:39.658600',NULL,'~',1,4,3,4,4,NULL),(3,'2025-02-20 12:35:33.782925','2025-02-20 12:39:07.935713','Feuerwehrhaus Vogling','24-055','',95.00,NULL,NULL,NULL,2.00,0.00,0.00,19,'2025-02-20 12:39:07.936659',NULL,'~',1,4,3,4,4,NULL),(3,'2025-02-20 12:35:33.782925','2025-02-20 12:39:30.272084','Feuerwehrhaus Vogling','24-055','',95.00,NULL,NULL,NULL,2.00,0.00,0.00,20,'2025-02-20 12:39:30.272917',NULL,'~',1,4,3,4,4,NULL),(3,'2025-02-20 12:35:33.782925','2025-02-20 12:40:08.109860','Feuerwehrhaus Vogling','24-055','',95.00,NULL,NULL,NULL,2.00,0.00,0.00,21,'2025-02-20 12:40:08.110809',NULL,'~',1,4,3,4,4,NULL),(3,'2025-02-20 12:35:33.782925','2025-02-20 12:42:02.114595','Feuerwehrhaus Vogling','24-055','',95.00,NULL,NULL,NULL,2.00,0.00,0.00,22,'2025-02-20 12:42:02.115516',NULL,'~',1,4,3,4,4,NULL),(4,'2025-02-26 05:14:03.791493','2025-02-26 05:14:03.791513','Garage Kunzmann','2025-23','',95.00,NULL,NULL,NULL,5.00,0.00,0.00,23,'2025-02-26 05:14:03.793046',NULL,'+',1,4,4,4,4,2),(4,'2025-02-26 05:14:03.791493','2025-02-26 05:25:56.802053','Garage Kunzmann','2025-23','<p>Erstellung einer Garage</p>',95.00,NULL,NULL,NULL,5.00,0.50,0.00,24,'2025-02-26 05:25:56.803022',NULL,'~',1,4,4,4,4,2);
/*!40000 ALTER TABLE `orders_historicalorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_historicalorderfeegroup`
--

DROP TABLE IF EXISTS `orders_historicalorderfeegroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_historicalorderfeegroup` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `eligible_costs` decimal(10,2) DEFAULT NULL,
  `fee_costs` decimal(10,2) DEFAULT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `fee_group_id` bigint(20) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `orders_historicalord_history_user_id_2d90def9_fk_auth_user` (`history_user_id`),
  KEY `orders_historicalorderfeegroup_id_bf4d22ba` (`id`),
  KEY `orders_historicalorderfeegroup_history_date_b67f053c` (`history_date`),
  KEY `orders_historicalorderfeegroup_created_by_id_d535d455` (`created_by_id`),
  KEY `orders_historicalorderfeegroup_fee_group_id_08c3eab9` (`fee_group_id`),
  KEY `orders_historicalorderfeegroup_updated_by_id_8f51d916` (`updated_by_id`),
  KEY `orders_historicalorderfeegroup_order_id_1fab947c` (`order_id`),
  CONSTRAINT `orders_historicalord_history_user_id_2d90def9_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_historicalorderfeegroup`
--

LOCK TABLES `orders_historicalorderfeegroup` WRITE;
/*!40000 ALTER TABLE `orders_historicalorderfeegroup` DISABLE KEYS */;
INSERT INTO `orders_historicalorderfeegroup` VALUES (1,'2025-01-21 21:19:26.250669','2025-01-21 21:19:26.250687',NULL,700000.00,1,'2025-01-21 21:19:26.252617',NULL,'+',1,1,1,1,1),(2,'2025-01-21 21:19:26.253803','2025-01-21 21:19:26.253820',NULL,500000.00,2,'2025-01-21 21:19:26.254286',NULL,'+',1,2,1,1,1),(3,'2025-02-20 12:35:33.785386','2025-02-20 12:35:33.785403',1217020.00,21187.22,3,'2025-02-20 12:35:33.786395',NULL,'+',4,2,4,4,3),(3,'2025-02-20 12:35:33.785386','2025-02-20 12:40:08.111979',1217020.00,70324.07,4,'2025-02-20 12:40:08.113684',NULL,'~',4,2,4,4,3),(3,'2025-02-20 12:35:33.785386','2025-02-20 12:42:02.116939',1217020.00,70624.07,5,'2025-02-20 12:42:02.117976',NULL,'~',4,2,4,4,3);
/*!40000 ALTER TABLE `orders_historicalorderfeegroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_historicalorderlineitem`
--

DROP TABLE IF EXISTS `orders_historicalorderlineitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_historicalorderlineitem` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `orders_historicalord_history_user_id_c21eae27_fk_auth_user` (`history_user_id`),
  KEY `orders_historicalorderlineitem_id_a3cce55d` (`id`),
  KEY `orders_historicalorderlineitem_history_date_3ba39f11` (`history_date`),
  KEY `orders_historicalorderlineitem_created_by_id_597bd40c` (`created_by_id`),
  KEY `orders_historicalorderlineitem_updated_by_id_ddc11968` (`updated_by_id`),
  KEY `orders_historicalorderlineitem_order_id_72d31d6c` (`order_id`),
  CONSTRAINT `orders_historicalord_history_user_id_c21eae27_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_historicalorderlineitem`
--

LOCK TABLES `orders_historicalorderlineitem` WRITE;
/*!40000 ALTER TABLE `orders_historicalorderlineitem` DISABLE KEYS */;
INSERT INTO `orders_historicalorderlineitem` VALUES (1,'2025-02-19 14:38:30.132054','2025-02-19 14:38:30.132071','<p>Erstellung Tragwerksplanung</p>',450.00,1,'2025-02-19 14:38:30.132623',NULL,'+',4,4,4,2),(2,'2025-02-19 14:38:30.133877','2025-02-19 14:38:30.133892','<p>Erstellung Bewehrungspl&auml;ne</p>',250.00,2,'2025-02-19 14:38:30.134352',NULL,'+',4,4,4,2),(3,'2025-02-19 14:38:30.135624','2025-02-19 14:38:30.135639','<p>Erstellung Brandschutzkonzept</p>',100.00,3,'2025-02-19 14:38:30.136693',NULL,'+',4,4,4,2),(3,'2025-02-19 14:38:30.135624','2025-02-19 14:44:12.020910','<p>Erstellung Brandschutzkonzept</p>\r\n<p>Annahme: Das Bauvorhaben ist nicht pr&uuml;fpfl&ouml;ichtig und eine Flachgr&uuml;ndung ist m&ouml;glich. Bei Terminen vor Ort oder &Auml;nderungen des Entwurfs wird der Zusatzaufwand auf Regie (95,00&euro;/h netto + 0,50 &euro;/km) abgerechnet.</p>',100.00,4,'2025-02-19 14:44:12.021929',NULL,'~',4,4,4,2),(4,'2025-02-26 05:25:56.804375','2025-02-26 05:25:56.804407','<p>Erstellung Tragwerksplanung inkl. Bewehrungszeichnung f&uuml;r die Bodenplatte</p>',950.00,5,'2025-02-26 05:25:56.804930',NULL,'+',4,4,4,4),(5,'2025-02-26 05:25:56.806821','2025-02-26 05:25:56.806836','<p>Brandschutzkonzept</p>',200.00,6,'2025-02-26 05:25:56.811504',NULL,'+',4,4,4,4);
/*!40000 ALTER TABLE `orders_historicalorderlineitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_historicalorderservicephase`
--

DROP TABLE IF EXISTS `orders_historicalorderservicephase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_historicalorderservicephase` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  `percent` decimal(5,2) DEFAULT NULL,
  `rebate` decimal(5,2) DEFAULT NULL,
  `include_in_total_amount` tinyint(1) NOT NULL,
  `weight` int(10) unsigned NOT NULL CHECK (`weight` >= 0),
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `service_phase_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `orders_historicalord_history_user_id_5a76cf14_fk_auth_user` (`history_user_id`),
  KEY `orders_historicalorderservicephase_id_d1bda09a` (`id`),
  KEY `orders_historicalorderservicephase_weight_0b2e9923` (`weight`),
  KEY `orders_historicalorderservicephase_history_date_6905bb50` (`history_date`),
  KEY `orders_historicalorderservicephase_created_by_id_9bd93140` (`created_by_id`),
  KEY `orders_historicalorderservicephase_updated_by_id_127d43de` (`updated_by_id`),
  KEY `orders_historicalorderservicephase_order_id_33fb8020` (`order_id`),
  KEY `orders_historicalorderservicephase_service_phase_id_7bec35d1` (`service_phase_id`),
  CONSTRAINT `orders_historicalord_history_user_id_5a76cf14_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_historicalorderservicephase`
--

LOCK TABLES `orders_historicalorderservicephase` WRITE;
/*!40000 ALTER TABLE `orders_historicalorderservicephase` DISABLE KEYS */;
INSERT INTO `orders_historicalorderservicephase` VALUES (1,'2025-01-21 21:19:26.255163','2025-01-21 21:19:26.255181','',NULL,NULL,1,0,1,'2025-01-21 21:19:26.255899',NULL,'+',1,1,1,1,7),(1,'2025-01-21 21:19:26.255163','2025-01-21 21:21:13.407343','',2.00,NULL,1,0,2,'2025-01-21 21:21:13.408271',NULL,'~',1,1,1,1,7),(6,'2025-02-20 12:38:39.659784','2025-02-20 12:38:39.659801','',NULL,NULL,1,0,7,'2025-02-20 12:38:39.662252',NULL,'+',4,4,4,3,4),(6,'2025-02-20 12:38:39.659784','2025-02-20 12:39:07.937839','',NULL,31.00,1,0,8,'2025-02-20 12:39:07.938538',NULL,'~',4,4,4,3,4),(7,'2025-02-20 12:39:07.939611','2025-02-20 12:39:07.939626','',NULL,31.00,1,0,9,'2025-02-20 12:39:07.941506',NULL,'+',4,4,4,3,5),(6,'2025-02-20 12:38:39.659784','2025-02-20 12:39:30.274159','',30.00,31.00,1,0,10,'2025-02-20 12:39:30.274810',NULL,'~',4,4,4,3,4),(7,'2025-02-20 12:39:07.939611','2025-02-20 12:39:30.275726','',30.00,31.00,1,0,11,'2025-02-20 12:39:30.277410',NULL,'~',4,4,4,3,5);
/*!40000 ALTER TABLE `orders_historicalorderservicephase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_historicalservicephase`
--

DROP TABLE IF EXISTS `orders_historicalservicephase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_historicalservicephase` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `lph` varchar(100) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `percent` decimal(5,2) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `fee_group_id` bigint(20) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `orders_historicalser_history_user_id_45c7ee79_fk_auth_user` (`history_user_id`),
  KEY `orders_historicalservicephase_id_56b3915d` (`id`),
  KEY `orders_historicalservicephase_history_date_24a29ed2` (`history_date`),
  KEY `orders_historicalservicephase_created_by_id_c52e646c` (`created_by_id`),
  KEY `orders_historicalservicephase_fee_group_id_5045de8a` (`fee_group_id`),
  KEY `orders_historicalservicephase_updated_by_id_b9e8fb66` (`updated_by_id`),
  CONSTRAINT `orders_historicalser_history_user_id_45c7ee79_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_historicalservicephase`
--

LOCK TABLES `orders_historicalservicephase` WRITE;
/*!40000 ALTER TABLE `orders_historicalservicephase` DISABLE KEYS */;
INSERT INTO `orders_historicalservicephase` VALUES (1,'2025-01-21 21:12:04.476320','2025-01-21 21:12:04.476337','LPH1','Grundlagenermittlung','<p>Kl&auml;rung der Aufgabenstellung, Analyse der Grundlagen</p>',3.00,1,'2025-01-21 21:12:04.477033',NULL,'+',1,2,1,1),(2,'2025-01-21 21:12:25.140520','2025-01-21 21:12:25.140538','LPH2','Vorplanung','<p>Erstellung von Planungskonzepten, Kostensch&auml;tzung</p>',10.00,2,'2025-01-21 21:12:25.141129',NULL,'+',1,2,1,1),(3,'2025-01-21 21:12:41.492480','2025-01-21 21:12:41.492497','LPH3','Entwurfsplanung','<p>Erstellung der Entwurfsplanung, Kostenberechnung</p>',15.00,3,'2025-01-21 21:12:41.493096',NULL,'+',1,2,1,1),(4,'2025-01-21 21:13:01.790893','2025-01-21 21:13:01.790910','LPH4','Genehmigungsplanung','<p>Erarbeitung und Einreichung der Bauantr&auml;ge</p>',30.00,4,'2025-01-21 21:13:01.791504',NULL,'+',1,2,1,1),(5,'2025-01-21 21:13:19.813632','2025-01-21 21:13:19.813650','LPH5','Ausführungsplanung','<p>Detaillierte Planung f&uuml;r die Bauausf&uuml;hrung</p>',40.00,5,'2025-01-21 21:13:19.814257',NULL,'+',1,2,1,1),(6,'2025-01-21 21:13:37.142017','2025-01-21 21:13:37.142034','LPH6','Vorbereitung der Vergabe','<p>Erstellung von Leistungsverzeichnissen</p>',2.00,6,'2025-01-21 21:13:37.143184',NULL,'+',1,2,1,1),(7,'2025-01-21 21:13:58.528274','2025-01-21 21:13:58.528291','LPH1','Grundlagenermittlung','',2.00,7,'2025-01-21 21:13:58.528868',NULL,'+',1,1,1,1),(8,'2025-01-21 21:14:20.432107','2025-01-21 21:14:20.432124','LPH2','Vorplanung (Projekt- und Planungsvorbereitung)','',7.00,8,'2025-01-21 21:14:20.432730',NULL,'+',1,1,1,1),(9,'2025-01-21 21:14:40.823882','2025-01-21 21:14:40.823899','LPH3','Entwurfsplanung (System- und Integrationsplanung)','',15.00,9,'2025-01-21 21:14:40.824495',NULL,'+',1,1,1,1),(10,'2025-01-21 21:15:05.082641','2025-01-21 21:15:05.082659','LPH4','Genehmigungsplanung','',3.00,10,'2025-01-21 21:15:05.083249',NULL,'+',1,1,1,1),(11,'2025-01-21 21:15:22.820078','2025-01-21 21:15:22.820096','LPH5','Ausführungsplanung','',25.00,11,'2025-01-21 21:15:22.820694',NULL,'+',1,1,1,1),(12,'2025-01-21 21:15:49.589820','2025-01-21 21:15:49.589838','LPH6','Vorbereitung der Vergabe','',10.00,12,'2025-01-21 21:15:49.590413',NULL,'+',1,1,1,1),(13,'2025-01-21 21:16:07.687045','2025-01-21 21:16:07.687075','LPH7','Mitwirkung bei der Vergabe','',4.00,13,'2025-01-21 21:16:07.687933',NULL,'+',1,1,1,1),(14,'2025-01-21 21:16:27.449121','2025-01-21 21:16:27.449137','LPH8','Objektüberwachung (Bauüberwachung)','',33.00,14,'2025-01-21 21:16:27.449776',NULL,'+',1,1,1,1),(15,'2025-01-21 21:16:44.615362','2025-01-21 21:16:44.615379','LPH9','Objektbetreuung und Dokumentation','',1.00,15,'2025-01-21 21:16:44.615962',NULL,'+',1,1,1,1),(7,'2025-01-21 21:13:58.000000','2025-01-21 21:21:11.134315','LPH1','Grundlagenermittlung','',2.00,16,'2025-01-21 21:21:11.135048',NULL,'~',1,1,1,1);
/*!40000 ALTER TABLE `orders_historicalservicephase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_historicaltag`
--

DROP TABLE IF EXISTS `orders_historicaltag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_historicaltag` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `color` varchar(7) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `orders_historicaltag_history_user_id_8563ae8d_fk_auth_user_id` (`history_user_id`),
  KEY `orders_historicaltag_id_da09a8ed` (`id`),
  KEY `orders_historicaltag_name_87f9387f` (`name`),
  KEY `orders_historicaltag_history_date_21d7cbc0` (`history_date`),
  KEY `orders_historicaltag_created_by_id_1d4d903c` (`created_by_id`),
  KEY `orders_historicaltag_updated_by_id_ace54855` (`updated_by_id`),
  CONSTRAINT `orders_historicaltag_history_user_id_8563ae8d_fk_auth_user_id` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_historicaltag`
--

LOCK TABLES `orders_historicaltag` WRITE;
/*!40000 ALTER TABLE `orders_historicaltag` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_historicaltag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_historicaltask`
--

DROP TABLE IF EXISTS `orders_historicaltask`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_historicaltask` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `document_id` bigint(20) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `orders_historicaltask_history_user_id_bed5829a_fk_auth_user_id` (`history_user_id`),
  KEY `orders_historicaltask_id_de895b2d` (`id`),
  KEY `orders_historicaltask_history_date_5ad8c2d5` (`history_date`),
  KEY `orders_historicaltask_created_by_id_5385b51d` (`created_by_id`),
  KEY `orders_historicaltask_document_id_718dc801` (`document_id`),
  KEY `orders_historicaltask_updated_by_id_56288187` (`updated_by_id`),
  KEY `orders_historicaltask_order_id_6d2e0989` (`order_id`),
  CONSTRAINT `orders_historicaltask_history_user_id_bed5829a_fk_auth_user_id` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_historicaltask`
--

LOCK TABLES `orders_historicaltask` WRITE;
/*!40000 ALTER TABLE `orders_historicaltask` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_historicaltask` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_historicaltaskposition`
--

DROP TABLE IF EXISTS `orders_historicaltaskposition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_historicaltaskposition` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `hours_worked` decimal(5,2) NOT NULL,
  `task_position_date` date NOT NULL,
  `distance_in_km` decimal(5,2) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `document_id` bigint(20) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `orders_historicaltas_history_user_id_79ac632b_fk_auth_user` (`history_user_id`),
  KEY `orders_historicaltaskposition_id_fd44e23f` (`id`),
  KEY `orders_historicaltaskposition_history_date_0b006f90` (`history_date`),
  KEY `orders_historicaltaskposition_created_by_id_01a7b588` (`created_by_id`),
  KEY `orders_historicaltaskposition_document_id_8702b324` (`document_id`),
  KEY `orders_historicaltaskposition_updated_by_id_1431dd97` (`updated_by_id`),
  KEY `orders_historicaltaskposition_task_id_1fdc21b0` (`task_id`),
  CONSTRAINT `orders_historicaltas_history_user_id_79ac632b_fk_auth_user` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_historicaltaskposition`
--

LOCK TABLES `orders_historicaltaskposition` WRITE;
/*!40000 ALTER TABLE `orders_historicaltaskposition` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_historicaltaskposition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_historicalvat`
--

DROP TABLE IF EXISTS `orders_historicalvat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_historicalvat` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `rate` decimal(5,2) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `history_id` int(11) NOT NULL AUTO_INCREMENT,
  `history_date` datetime(6) NOT NULL,
  `history_change_reason` varchar(100) DEFAULT NULL,
  `history_type` varchar(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `history_user_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`history_id`),
  KEY `orders_historicalvat_history_user_id_f78ebc60_fk_auth_user_id` (`history_user_id`),
  KEY `orders_historicalvat_id_12940645` (`id`),
  KEY `orders_historicalvat_history_date_552750e6` (`history_date`),
  KEY `orders_historicalvat_created_by_id_4d57ba9d` (`created_by_id`),
  KEY `orders_historicalvat_updated_by_id_3251203f` (`updated_by_id`),
  CONSTRAINT `orders_historicalvat_history_user_id_f78ebc60_fk_auth_user_id` FOREIGN KEY (`history_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_historicalvat`
--

LOCK TABLES `orders_historicalvat` WRITE;
/*!40000 ALTER TABLE `orders_historicalvat` DISABLE KEYS */;
INSERT INTO `orders_historicalvat` VALUES (1,'2025-01-21 20:11:30.126256','2025-01-21 20:11:30.126275','Steuerfrei',0.00,0,1,'2025-01-21 20:11:30.126965',NULL,'+',1,1,1),(2,'2025-01-21 20:11:53.362763','2025-01-21 20:11:53.362781','19%',19.00,1,2,'2025-01-21 20:11:53.363361',NULL,'+',1,1,1);
/*!40000 ALTER TABLE `orders_historicalvat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_order`
--

DROP TABLE IF EXISTS `orders_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `nr` varchar(10) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `hourly_rate` decimal(6,2) DEFAULT NULL,
  `flat_rate` decimal(10,2) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `additional_costs` decimal(5,2) DEFAULT NULL,
  `km_cost` decimal(5,2) DEFAULT NULL,
  `km` decimal(12,2) DEFAULT NULL,
  `company_id` bigint(20) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `vat_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nr` (`nr`),
  KEY `orders_order_vat_id_74054e49_fk_orders_vat_id` (`vat_id`),
  KEY `orders_order_company_id_fbc7ca11_fk_company_company_id` (`company_id`),
  KEY `orders_order_created_by_id_d5f5e69c_fk_auth_user_id` (`created_by_id`),
  KEY `orders_order_customer_id_0b76f6a4_fk_customers_customer_id` (`customer_id`),
  KEY `orders_order_updated_by_id_ebcc0e59_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `orders_order_company_id_fbc7ca11_fk_company_company_id` FOREIGN KEY (`company_id`) REFERENCES `company_company` (`id`),
  CONSTRAINT `orders_order_created_by_id_d5f5e69c_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `orders_order_customer_id_0b76f6a4_fk_customers_customer_id` FOREIGN KEY (`customer_id`) REFERENCES `customers_customer` (`id`),
  CONSTRAINT `orders_order_updated_by_id_ebcc0e59_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `orders_order_vat_id_74054e49_fk_orders_vat_id` FOREIGN KEY (`vat_id`) REFERENCES `orders_vat` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_order`
--

LOCK TABLES `orders_order` WRITE;
/*!40000 ALTER TABLE `orders_order` DISABLE KEYS */;
INSERT INTO `orders_order` VALUES (1,'2025-01-21 21:19:26.245205','2025-01-21 21:21:13.403164','Testprojekt','25-001','',85.00,NULL,NULL,NULL,5.00,0.00,0.00,1,1,1,1,2),(2,'2025-02-19 14:38:30.129794','2025-02-20 12:33:56.419533','Neubau eines Geräteschuppens','25-022','',95.00,NULL,NULL,NULL,5.00,0.00,0.00,1,4,2,4,2),(3,'2025-02-20 12:35:33.782925','2025-02-20 12:42:02.114595','Feuerwehrhaus Vogling','24-055','',95.00,NULL,NULL,NULL,2.00,0.00,0.00,1,4,3,4,NULL),(4,'2025-02-26 05:14:03.791493','2025-02-26 05:25:56.802053','Garage Kunzmann','2025-23','<p>Erstellung einer Garage</p>',95.00,NULL,NULL,NULL,5.00,0.50,0.00,1,4,4,4,2);
/*!40000 ALTER TABLE `orders_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_order_tags`
--

DROP TABLE IF EXISTS `orders_order_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_order_tags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_order_tags_order_id_tag_id_fd57bad8_uniq` (`order_id`,`tag_id`),
  KEY `orders_order_tags_tag_id_9bc38bf0_fk_orders_tag_id` (`tag_id`),
  CONSTRAINT `orders_order_tags_order_id_e3e9ce82_fk_orders_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`id`),
  CONSTRAINT `orders_order_tags_tag_id_9bc38bf0_fk_orders_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `orders_tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_order_tags`
--

LOCK TABLES `orders_order_tags` WRITE;
/*!40000 ALTER TABLE `orders_order_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_order_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_orderfeegroup`
--

DROP TABLE IF EXISTS `orders_orderfeegroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_orderfeegroup` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `eligible_costs` decimal(10,2) DEFAULT NULL,
  `fee_costs` decimal(10,2) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `fee_group_id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_orderfeegroup_order_id_fee_group_id_5f765d20_uniq` (`order_id`,`fee_group_id`),
  KEY `orders_orderfeegroup_created_by_id_99e1e87a_fk_auth_user_id` (`created_by_id`),
  KEY `orders_orderfeegroup_fee_group_id_55433cc6_fk_orders_feegroup_id` (`fee_group_id`),
  KEY `orders_orderfeegroup_updated_by_id_c7b4366b_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `orders_orderfeegroup_created_by_id_99e1e87a_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `orders_orderfeegroup_fee_group_id_55433cc6_fk_orders_feegroup_id` FOREIGN KEY (`fee_group_id`) REFERENCES `orders_feegroup` (`id`),
  CONSTRAINT `orders_orderfeegroup_order_id_7d47405b_fk_orders_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`id`),
  CONSTRAINT `orders_orderfeegroup_updated_by_id_c7b4366b_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_orderfeegroup`
--

LOCK TABLES `orders_orderfeegroup` WRITE;
/*!40000 ALTER TABLE `orders_orderfeegroup` DISABLE KEYS */;
INSERT INTO `orders_orderfeegroup` VALUES (1,'2025-01-21 21:19:26.250669','2025-01-21 21:19:26.250687',NULL,700000.00,1,1,1,1),(2,'2025-01-21 21:19:26.253803','2025-01-21 21:19:26.253820',NULL,500000.00,1,2,1,1),(3,'2025-02-20 12:35:33.785386','2025-02-20 12:42:02.116939',1217020.00,70624.07,4,2,3,4);
/*!40000 ALTER TABLE `orders_orderfeegroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_orderlineitem`
--

DROP TABLE IF EXISTS `orders_orderlineitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_orderlineitem` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `order_id` bigint(20) NOT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_orderlineitem_created_by_id_ca8f8772_fk_auth_user_id` (`created_by_id`),
  KEY `orders_orderlineitem_order_id_a1dcb2e4_fk_orders_order_id` (`order_id`),
  KEY `orders_orderlineitem_updated_by_id_4b1e38b3_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `orders_orderlineitem_created_by_id_ca8f8772_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `orders_orderlineitem_order_id_a1dcb2e4_fk_orders_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`id`),
  CONSTRAINT `orders_orderlineitem_updated_by_id_4b1e38b3_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_orderlineitem`
--

LOCK TABLES `orders_orderlineitem` WRITE;
/*!40000 ALTER TABLE `orders_orderlineitem` DISABLE KEYS */;
INSERT INTO `orders_orderlineitem` VALUES (1,'2025-02-19 14:38:30.132054','2025-02-19 14:38:30.132071','<p>Erstellung Tragwerksplanung</p>',450.00,4,2,4),(2,'2025-02-19 14:38:30.133877','2025-02-19 14:38:30.133892','<p>Erstellung Bewehrungspl&auml;ne</p>',250.00,4,2,4),(3,'2025-02-19 14:38:30.135624','2025-02-19 14:44:12.020910','<p>Erstellung Brandschutzkonzept</p>\r\n<p>Annahme: Das Bauvorhaben ist nicht pr&uuml;fpfl&ouml;ichtig und eine Flachgr&uuml;ndung ist m&ouml;glich. Bei Terminen vor Ort oder &Auml;nderungen des Entwurfs wird der Zusatzaufwand auf Regie (95,00&euro;/h netto + 0,50 &euro;/km) abgerechnet.</p>',100.00,4,2,4),(4,'2025-02-26 05:25:56.804375','2025-02-26 05:25:56.804407','<p>Erstellung Tragwerksplanung inkl. Bewehrungszeichnung f&uuml;r die Bodenplatte</p>',950.00,4,4,4),(5,'2025-02-26 05:25:56.806821','2025-02-26 05:25:56.806836','<p>Brandschutzkonzept</p>',200.00,4,4,4);
/*!40000 ALTER TABLE `orders_orderlineitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_orderservicephase`
--

DROP TABLE IF EXISTS `orders_orderservicephase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_orderservicephase` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` longtext DEFAULT NULL,
  `percent` decimal(5,2) DEFAULT NULL,
  `rebate` decimal(5,2) DEFAULT NULL,
  `include_in_total_amount` tinyint(1) NOT NULL,
  `weight` int(10) unsigned NOT NULL CHECK (`weight` >= 0),
  `created_by_id` int(11) DEFAULT NULL,
  `order_id` bigint(20) NOT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  `service_phase_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_orderservicephase_created_by_id_36421b80_fk_auth_user_id` (`created_by_id`),
  KEY `orders_orderservicephase_order_id_5a470a25_fk_orders_order_id` (`order_id`),
  KEY `orders_orderservicephase_updated_by_id_f540b5f2_fk_auth_user_id` (`updated_by_id`),
  KEY `orders_orderservicep_service_phase_id_b2b70832_fk_orders_se` (`service_phase_id`),
  KEY `orders_orderservicephase_weight_44d405c8` (`weight`),
  CONSTRAINT `orders_orderservicep_service_phase_id_b2b70832_fk_orders_se` FOREIGN KEY (`service_phase_id`) REFERENCES `orders_servicephase` (`id`),
  CONSTRAINT `orders_orderservicephase_created_by_id_36421b80_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `orders_orderservicephase_order_id_5a470a25_fk_orders_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`id`),
  CONSTRAINT `orders_orderservicephase_updated_by_id_f540b5f2_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_orderservicephase`
--

LOCK TABLES `orders_orderservicephase` WRITE;
/*!40000 ALTER TABLE `orders_orderservicephase` DISABLE KEYS */;
INSERT INTO `orders_orderservicephase` VALUES (1,'2025-01-21 21:19:26.255163','2025-01-21 21:21:13.407343','',2.00,NULL,1,0,1,1,1,7),(6,'2025-02-20 12:38:39.659784','2025-02-20 12:39:30.274159','',30.00,31.00,1,0,4,3,4,4),(7,'2025-02-20 12:39:07.939611','2025-02-20 12:39:30.275726','',30.00,31.00,1,0,4,3,4,5);
/*!40000 ALTER TABLE `orders_orderservicephase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_servicephase`
--

DROP TABLE IF EXISTS `orders_servicephase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_servicephase` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `lph` varchar(100) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `percent` decimal(5,2) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `fee_group_id` bigint(20) NOT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_servicephase_created_by_id_c6fdf87d_fk_auth_user_id` (`created_by_id`),
  KEY `orders_servicephase_fee_group_id_3c4a7ba9_fk_orders_feegroup_id` (`fee_group_id`),
  KEY `orders_servicephase_updated_by_id_bd2fdbe2_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `orders_servicephase_created_by_id_c6fdf87d_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `orders_servicephase_fee_group_id_3c4a7ba9_fk_orders_feegroup_id` FOREIGN KEY (`fee_group_id`) REFERENCES `orders_feegroup` (`id`),
  CONSTRAINT `orders_servicephase_updated_by_id_bd2fdbe2_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_servicephase`
--

LOCK TABLES `orders_servicephase` WRITE;
/*!40000 ALTER TABLE `orders_servicephase` DISABLE KEYS */;
INSERT INTO `orders_servicephase` VALUES (1,'2025-01-21 21:12:04.476320','2025-01-21 21:12:04.476337','LPH1','Grundlagenermittlung','<p>Kl&auml;rung der Aufgabenstellung, Analyse der Grundlagen</p>',3.00,1,2,1),(2,'2025-01-21 21:12:25.140520','2025-01-21 21:12:25.140538','LPH2','Vorplanung','<p>Erstellung von Planungskonzepten, Kostensch&auml;tzung</p>',10.00,1,2,1),(3,'2025-01-21 21:12:41.492480','2025-01-21 21:12:41.492497','LPH3','Entwurfsplanung','<p>Erstellung der Entwurfsplanung, Kostenberechnung</p>',15.00,1,2,1),(4,'2025-01-21 21:13:01.790893','2025-01-21 21:13:01.790910','LPH4','Genehmigungsplanung','<p>Erarbeitung und Einreichung der Bauantr&auml;ge</p>',30.00,1,2,1),(5,'2025-01-21 21:13:19.813632','2025-01-21 21:13:19.813650','LPH5','Ausführungsplanung','<p>Detaillierte Planung f&uuml;r die Bauausf&uuml;hrung</p>',40.00,1,2,1),(6,'2025-01-21 21:13:37.142017','2025-01-21 21:13:37.142034','LPH6','Vorbereitung der Vergabe','<p>Erstellung von Leistungsverzeichnissen</p>',2.00,1,2,1),(7,'2025-01-21 21:13:58.000000','2025-01-21 21:21:11.134315','LPH1','Grundlagenermittlung','',2.00,1,1,1),(8,'2025-01-21 21:14:20.432107','2025-01-21 21:14:20.432124','LPH2','Vorplanung (Projekt- und Planungsvorbereitung)','',7.00,1,1,1),(9,'2025-01-21 21:14:40.823882','2025-01-21 21:14:40.823899','LPH3','Entwurfsplanung (System- und Integrationsplanung)','',15.00,1,1,1),(10,'2025-01-21 21:15:05.082641','2025-01-21 21:15:05.082659','LPH4','Genehmigungsplanung','',3.00,1,1,1),(11,'2025-01-21 21:15:22.820078','2025-01-21 21:15:22.820096','LPH5','Ausführungsplanung','',25.00,1,1,1),(12,'2025-01-21 21:15:49.589820','2025-01-21 21:15:49.589838','LPH6','Vorbereitung der Vergabe','',10.00,1,1,1),(13,'2025-01-21 21:16:07.687045','2025-01-21 21:16:07.687075','LPH7','Mitwirkung bei der Vergabe','',4.00,1,1,1),(14,'2025-01-21 21:16:27.449121','2025-01-21 21:16:27.449137','LPH8','Objektüberwachung (Bauüberwachung)','',33.00,1,1,1),(15,'2025-01-21 21:16:44.615362','2025-01-21 21:16:44.615379','LPH9','Objektbetreuung und Dokumentation','',1.00,1,1,1);
/*!40000 ALTER TABLE `orders_servicephase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_tag`
--

DROP TABLE IF EXISTS `orders_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_tag` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `color` varchar(7) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `orders_tag_created_by_id_60aea1de_fk_auth_user_id` (`created_by_id`),
  KEY `orders_tag_updated_by_id_3558e755_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `orders_tag_created_by_id_60aea1de_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `orders_tag_updated_by_id_3558e755_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_tag`
--

LOCK TABLES `orders_tag` WRITE;
/*!40000 ALTER TABLE `orders_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_task`
--

DROP TABLE IF EXISTS `orders_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `document_id` bigint(20) DEFAULT NULL,
  `order_id` bigint(20) NOT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_task_created_by_id_de028ba0_fk_auth_user_id` (`created_by_id`),
  KEY `orders_task_document_id_879f32ee_fk_orders_document_id` (`document_id`),
  KEY `orders_task_order_id_3d00e71c_fk_orders_order_id` (`order_id`),
  KEY `orders_task_updated_by_id_8d51fc11_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `orders_task_created_by_id_de028ba0_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `orders_task_document_id_879f32ee_fk_orders_document_id` FOREIGN KEY (`document_id`) REFERENCES `orders_document` (`id`),
  CONSTRAINT `orders_task_order_id_3d00e71c_fk_orders_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders_order` (`id`),
  CONSTRAINT `orders_task_updated_by_id_8d51fc11_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_task`
--

LOCK TABLES `orders_task` WRITE;
/*!40000 ALTER TABLE `orders_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_task_tags`
--

DROP TABLE IF EXISTS `orders_task_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_task_tags` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `task_id` bigint(20) NOT NULL,
  `tag_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `orders_task_tags_task_id_tag_id_a422adaf_uniq` (`task_id`,`tag_id`),
  KEY `orders_task_tags_tag_id_c46962f3_fk_orders_tag_id` (`tag_id`),
  CONSTRAINT `orders_task_tags_tag_id_c46962f3_fk_orders_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `orders_tag` (`id`),
  CONSTRAINT `orders_task_tags_task_id_bf6ba84b_fk_orders_task_id` FOREIGN KEY (`task_id`) REFERENCES `orders_task` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_task_tags`
--

LOCK TABLES `orders_task_tags` WRITE;
/*!40000 ALTER TABLE `orders_task_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_task_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_taskposition`
--

DROP TABLE IF EXISTS `orders_taskposition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_taskposition` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `hours_worked` decimal(5,2) NOT NULL,
  `task_position_date` date NOT NULL,
  `distance_in_km` decimal(5,2) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `document_id` bigint(20) DEFAULT NULL,
  `task_id` bigint(20) NOT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_taskposition_created_by_id_4f3b4145_fk_auth_user_id` (`created_by_id`),
  KEY `orders_taskposition_document_id_7d225fe0_fk_orders_document_id` (`document_id`),
  KEY `orders_taskposition_task_id_bf1a7e6a_fk_orders_task_id` (`task_id`),
  KEY `orders_taskposition_updated_by_id_05daa132_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `orders_taskposition_created_by_id_4f3b4145_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `orders_taskposition_document_id_7d225fe0_fk_orders_document_id` FOREIGN KEY (`document_id`) REFERENCES `orders_document` (`id`),
  CONSTRAINT `orders_taskposition_task_id_bf1a7e6a_fk_orders_task_id` FOREIGN KEY (`task_id`) REFERENCES `orders_task` (`id`),
  CONSTRAINT `orders_taskposition_updated_by_id_05daa132_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_taskposition`
--

LOCK TABLES `orders_taskposition` WRITE;
/*!40000 ALTER TABLE `orders_taskposition` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders_taskposition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_vat`
--

DROP TABLE IF EXISTS `orders_vat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders_vat` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `rate` decimal(5,2) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `created_by_id` int(11) DEFAULT NULL,
  `updated_by_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_vat_created_by_id_cf04a763_fk_auth_user_id` (`created_by_id`),
  KEY `orders_vat_updated_by_id_05b13ddf_fk_auth_user_id` (`updated_by_id`),
  CONSTRAINT `orders_vat_created_by_id_cf04a763_fk_auth_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `orders_vat_updated_by_id_05b13ddf_fk_auth_user_id` FOREIGN KEY (`updated_by_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_vat`
--

LOCK TABLES `orders_vat` WRITE;
/*!40000 ALTER TABLE `orders_vat` DISABLE KEYS */;
INSERT INTO `orders_vat` VALUES (1,'2025-01-21 20:11:30.126256','2025-01-21 20:11:30.126275','Steuerfrei',0.00,0,1,1),(2,'2025-01-21 20:11:53.362763','2025-01-21 20:11:53.362781','19%',19.00,1,1,1);
/*!40000 ALTER TABLE `orders_vat` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-17 19:00:57
