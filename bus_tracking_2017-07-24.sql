# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.6.28)
# Database: bus_tracking
# Generation Time: 2017-07-24 07:16:34 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table admin
# ------------------------------------------------------------

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(500) NOT NULL,
  `admin_position` varchar(200) NOT NULL,
  `admin_dept` varchar(200) NOT NULL,
  `admin_email` varchar(200) NOT NULL,
  `admin_phone` int(11) DEFAULT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;

INSERT INTO `admin` (`admin_id`, `admin_name`, `admin_position`, `admin_dept`, `admin_email`, `admin_phone`)
VALUES
	(1,'Ali','HR Manager','Human Resource','ali@company.com',192610987),
	(2,'Abu','HR Executive','Human Resource','abu@company.com',123790912);

/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table bus
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bus`;

CREATE TABLE `bus` (
  `bus_no` varchar(10) NOT NULL,
  `bus_plate_no` varchar(20) NOT NULL,
  `driver_id` int(11) NOT NULL,
  `bus_location` int(11) NOT NULL,
  `bus_route` int(11) NOT NULL,
  PRIMARY KEY (`bus_plate_no`),
  UNIQUE KEY `driver_id` (`driver_id`),
  KEY `fk_bus_driver_id` (`driver_id`),
  KEY `fk_bus_location` (`bus_location`),
  CONSTRAINT `fk_bus_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `bus_driver` (`driver_id`),
  CONSTRAINT `fk_bus_location` FOREIGN KEY (`bus_location`) REFERENCES `location` (`location_position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `bus` WRITE;
/*!40000 ALTER TABLE `bus` DISABLE KEYS */;

INSERT INTO `bus` (`bus_no`, `bus_plate_no`, `driver_id`, `bus_location`, `bus_route`)
VALUES
	('AJ01','WFT2456',5,15,3),
	('T305','WGT2567',3,18,1),
	('T305','WTF2033',1,21,2);

/*!40000 ALTER TABLE `bus` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table bus_driver
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bus_driver`;

CREATE TABLE `bus_driver` (
  `driver_id` int(11) NOT NULL AUTO_INCREMENT,
  `driver_name` varchar(500) NOT NULL,
  `driver_phone` int(11) NOT NULL,
  `driver_license_no` varchar(50) NOT NULL,
  PRIMARY KEY (`driver_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `bus_driver` WRITE;
/*!40000 ALTER TABLE `bus_driver` DISABLE KEYS */;

INSERT INTO `bus_driver` (`driver_id`, `driver_name`, `driver_phone`, `driver_license_no`)
VALUES
	(1,'Fawaz',123456789,'AZ 1234'),
	(2,'Amin',56729812,'HJ4569'),
	(3,'Aminah',987654321,'HJK 6789'),
	(4,'Lisa',2147483647,'HJP26718'),
	(5,'Sani',1236784,'THJ17837'),
	(6,'Ayeen Hashim',12784622,'RTWEW7318381'),
	(7,'Fizreen',2147483647,'TYW9898131'),
	(8,'Farra',2147483647,'QIOPEY73982HDG2');

/*!40000 ALTER TABLE `bus_driver` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table bus_location
# ------------------------------------------------------------

DROP TABLE IF EXISTS `bus_location`;

CREATE TABLE `bus_location` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `bus_no` varchar(10) NOT NULL DEFAULT '',
  `latitude` varchar(50) NOT NULL DEFAULT '',
  `longitude` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `bus_location` WRITE;
/*!40000 ALTER TABLE `bus_location` DISABLE KEYS */;

INSERT INTO `bus_location` (`id`, `bus_no`, `latitude`, `longitude`)
VALUES
	(1,'T305',' 3.2013183','101.7534875'),
	(2,'T305','3.2036402','101.7517709'),
	(3,'T305','3.2070573','101.752125');

/*!40000 ALTER TABLE `bus_location` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table client
# ------------------------------------------------------------

DROP TABLE IF EXISTS `client`;

CREATE TABLE `client` (
  `client_id` int(11) NOT NULL AUTO_INCREMENT,
  `current_position` int(11) NOT NULL,
  `client_destination` int(11) NOT NULL,
  PRIMARY KEY (`client_id`),
  KEY `fk_location` (`current_position`),
  KEY `fk_destination` (`client_destination`),
  CONSTRAINT `fk_destination` FOREIGN KEY (`client_destination`) REFERENCES `location` (`location_position`),
  CONSTRAINT `fk_location` FOREIGN KEY (`current_position`) REFERENCES `location` (`location_position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;

INSERT INTO `client` (`client_id`, `current_position`, `client_destination`)
VALUES
	(1,2,8),
	(2,3,9),
	(3,22,7),
	(4,4,8),
	(5,7,9),
	(6,15,18);

/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table location
# ------------------------------------------------------------

DROP TABLE IF EXISTS `location`;

CREATE TABLE `location` (
  `location_position` int(11) NOT NULL,
  `latitude` varchar(50) NOT NULL DEFAULT '',
  `longitude` varchar(50) NOT NULL DEFAULT '',
  `location_name` varchar(500) NOT NULL,
  `latitude_longitude` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`location_position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;

INSERT INTO `location` (`location_position`, `latitude`, `longitude`, `location_name`, `latitude_longitude`)
VALUES
	(0,'','','','0'),
	(1,'3.198869','101.73753099999999','LRT Sri Rampai','3.198869,101.73753099999999'),
	(2,'3.19982','101.75213020000001','Section 4 Wangsa Maju Market','3.19982,101.75213020000001'),
	(3,'3.209397','101.73721610000007','Section 4 Wangsa Maju Flats','3.209397,101.73721610000007'),
	(4,'3.209695599999999','101.74845030000006','Melawati Mall','3.209695599999999,101.74845030000006'),
	(5,'3.2061279','101.75320220000003','Jalan Permata 16','3.2061279,101.75320220000003'),
	(6,'3.203787299999999','101.75335029999997','Jalan Permata 22','3.203787299999999,101.75335029999997'),
	(7,'3.2051927','101.75596910000002','Taman Lembah Keramat','3.2051927,101.75596910000002'),
	(8,'3.198865999999999','101.75979710000001','Lembah Keramat Secondary School','3.198865999999999,101.75979710000001'),
	(9,'3.1968387','101.76003779999996','Seri Keramat Secondary School','3.1968387,101.76003779999996'),
	(10,'3.1962486','101.764452','Taman Ar Ridhuan Flats Ukay Perdana','3.1962486,101.764452'),
	(11,'3.2023448','101.76772370000003','Tijani Ukay','3.2023448,101.76772370000003'),
	(12,'3.1992485','101.77572580000003','Sering Ukay 2','3.1992485,101.77572580000003'),
	(13,'3.2029293','101.7757431','Apartmen Sri Melor Ukay Perdana','3.2029293, 01.7757431'),
	(14,'3.206476','101.773503','Ukay Perdana 4','3.206476, 01.773503'),
	(15,'3.206226999999999','101.772692','Sri Baiduri Ukay Perdana','3.206226999999999,101.772692'),
	(16,'3.207198899999999','101.7795327','Spring Ville Apartment Ukay Perdana','3.207198899999999,101.7795327'),
	(17,'3.2070694','101.78050529999996','Ukay Perdana Business Area','3.2070694,101.78050529999996'),
	(18,'3.206010699999999','101.77256999999997','Ukay Perdana 3','3.206010699999999,101.77256999999997'),
	(19,'3.211537','101.78040599999997','Sri Kayangan Apartment Ukay Perdana','3.211537,101.78040599999997'),
	(20,'3.202477','101.77853200000004','Sri Impian Flats Ukay Perdana','3.202477,101.77853200000004'),
	(21,'3.190653','101.77072810000004','Taman Kelab Ukay','3.190653,101.77072810000004'),
	(22,'3.1943339','101.76696620000007','Taman Andaman Ukay Perdana','3.1943339,101.76696620000007'),
	(23,'3.197594','101.75773279999999','Taman Sri Keramat Tengah','3.197594,101.75773279999999'),
	(24,'3.1995218','101.75926249999998','Jalan AU 5','3.1995218,101.75926249999998'),
	(25,'3.2017358','101.75549750000005','Dewan AU 5','3.2017358,101.75549750000005'),
	(26,'3.201273800000001','101.7545235','Jalan AU5d','3.201273800000001,101.7545235'),
	(27,'3.2043494','101.74996910000004','Jalan Permata 10','3.2043494,101.74996910000004'),
	(28,'3.2070327','101.75186880000001','Giant Hypermarket Ulu Kelang','3.2070327,101.75186880000001'),
	(29,'3.1426195','101.74326799999994','Jalan Permata MRR2','3.1426195, 101.74326799999994'),
	(30,'3.207281','101.74317700000006','Wangsa Melawati','3.207281,101.74317700000006'),
	(31,'3.2065681','101.74479599999995','Wangsa Ceria','3.2065681, 101.74479599999995'),
	(32,'3.195629','101.74303299999997','Aeon Big Wangsa Maju','3.195629,101.74303299999997');

/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table route
# ------------------------------------------------------------

DROP TABLE IF EXISTS `route`;

CREATE TABLE `route` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `route_id` int(11) NOT NULL,
  `stop_index` int(11) NOT NULL,
  `route_start` int(11) NOT NULL,
  `route_end` int(11) NOT NULL,
  `current_stop` int(11) NOT NULL,
  `next_stop` int(11) NOT NULL,
  `bus_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_route_start` (`route_start`),
  KEY `fk_route_end` (`route_end`),
  KEY `fk_currentstop` (`current_stop`),
  KEY `fk_nextstop` (`next_stop`),
  CONSTRAINT `fk_currentstop` FOREIGN KEY (`current_stop`) REFERENCES `location` (`location_position`),
  CONSTRAINT `fk_nextstop` FOREIGN KEY (`next_stop`) REFERENCES `location` (`location_position`),
  CONSTRAINT `fk_route_end` FOREIGN KEY (`route_end`) REFERENCES `location` (`location_position`),
  CONSTRAINT `fk_route_start` FOREIGN KEY (`route_start`) REFERENCES `location` (`location_position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;

INSERT INTO `route` (`id`, `route_id`, `stop_index`, `route_start`, `route_end`, `current_stop`, `next_stop`, `bus_time`)
VALUES
	(1,1,1,1,18,1,2,5),
	(2,1,2,1,18,2,3,6),
	(3,1,3,1,18,3,4,6),
	(4,1,4,1,18,4,5,7),
	(5,1,5,1,18,5,6,4),
	(6,1,6,1,18,6,7,9),
	(7,1,7,1,18,7,8,7),
	(8,1,8,1,18,8,9,7),
	(9,1,9,1,18,9,10,6),
	(10,1,10,1,18,10,11,4),
	(11,1,11,1,18,11,12,8),
	(12,1,12,1,18,12,13,7),
	(13,1,13,1,18,13,14,5),
	(14,1,14,1,18,14,15,6),
	(15,1,15,1,18,15,16,4),
	(16,1,16,1,18,16,17,8),
	(17,1,17,1,18,17,18,6),
	(18,2,1,18,1,18,19,6),
	(19,2,2,18,1,19,20,7),
	(20,2,3,18,1,20,13,5),
	(21,2,4,18,1,13,14,6),
	(22,2,5,18,1,14,15,4),
	(23,2,6,18,1,15,21,8),
	(24,2,7,18,1,21,22,6),
	(25,2,8,18,1,22,23,5),
	(26,2,9,18,1,23,24,3),
	(27,2,10,18,1,24,25,5),
	(28,2,11,18,1,25,26,8),
	(29,2,12,18,1,26,27,5),
	(30,2,13,18,1,27,28,6),
	(31,2,14,18,1,28,29,7),
	(32,2,15,18,1,29,30,7),
	(33,2,16,18,1,30,31,5),
	(34,2,17,18,1,31,32,7),
	(35,2,18,18,1,32,1,5),
	(36,3,1,5,18,5,6,4),
	(37,3,2,5,18,6,7,9),
	(38,3,3,5,18,7,8,7),
	(39,3,4,5,18,8,9,7),
	(40,3,5,5,18,9,10,6),
	(41,3,6,5,18,10,11,4),
	(42,3,7,5,18,11,12,8),
	(43,3,8,5,18,12,16,10),
	(44,3,9,5,18,16,17,8),
	(45,3,10,5,18,17,18,6);

/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
