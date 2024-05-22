-- MariaDB dump 10.19-11.3.2-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: board
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB

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
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `author` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `age` tinyint(3) unsigned DEFAULT NULL,
  `profile_image` longblob DEFAULT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `birth_day` date DEFAULT NULL,
  `created_time` datetime DEFAULT current_timestamp(),
  `post_count` int(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES
(1,'abc','abc2@test.com',NULL,NULL,24,NULL,'user',NULL,NULL,0),
(2,'홍길동','hello2@naer.com',NULL,NULL,25,NULL,'user',NULL,NULL,0),
(3,'홍길동','hello1@naer.com',NULL,NULL,9,NULL,'user',NULL,NULL,0),
(4,'rnjscogns4','99cogns4@naver.com',NULL,NULL,13,NULL,'user',NULL,NULL,0),
(5,'권채훈','cogns10@naver.com',NULL,NULL,45,NULL,'user',NULL,'1999-11-03 05:02:25',0),
(6,'김하린','cogns11@naver.com',NULL,NULL,30,NULL,'user',NULL,'2024-05-17 12:31:18',0),
(7,'손석영','hello4@naver.com',NULL,NULL,27,NULL,'user',NULL,'2024-05-17 16:19:39',0),
(8,'rnjscogns3','99cogns3@naver.com',NULL,NULL,21,NULL,'user',NULL,NULL,0),
(9,NULL,NULL,NULL,NULL,18,NULL,'user',NULL,'2024-05-20 12:25:35',0),
(10,'kim','kim@naver.com',NULL,NULL,37,NULL,'user',NULL,'2024-05-20 15:38:46',0),
(11,'kim','kim2@naver.com',NULL,NULL,26,NULL,'user',NULL,'2024-05-20 15:39:38',0);
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cogns`
--

DROP TABLE IF EXISTS `cogns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cogns` (
  `id` int(11) NOT NULL,
  `name` varchar(10) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cogns`
--

LOCK TABLES `cogns` WRITE;
/*!40000 ALTER TABLE `cogns` DISABLE KEYS */;
INSERT INTO `cogns` VALUES
(1,'kch','m',26),
(2,'kjo','m',26),
(3,'pjy','w',22),
(4,'kwj','m',28),
(5,'wwc','w',24),
(6,'khm','m',34),
(8,'yjh','m',56),
(9,'hhj','w',23),
(10,'kje','w',22),
(11,'shj','w',46),
(12,'kkj','m',56),
(13,'kdv','w',13),
(14,'kmk','m',29),
(15,'nwh','m',26);
/*!40000 ALTER TABLE `cogns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `post` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `contents` varchar(3000) DEFAULT NULL,
  `author_id` bigint(20) DEFAULT NULL,
  `price` decimal(10,3) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `user_id` char(36) DEFAULT uuid(),
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_author_fk` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES
(1,'hello','hello java',1,1000.000,'2024-06-11 12:10:10','02cc3739-141f-11ef-9fa4-a4f93399797d'),
(2,'hello2','hello java',2,3000.000,'2023-12-19 05:35:20','02cc3c58-141f-11ef-9fa4-a4f93399797d'),
(3,'hello3','',2,6000.000,'2024-09-29 04:03:22','02cc3d1e-141f-11ef-9fa4-a4f93399797d'),
(4,'hello4','hello java5',5,7000.000,NULL,'02cc4055-141f-11ef-9fa4-a4f93399797d'),
(5,'hello5','hello java6',5,2000.000,'2022-12-30 12:11:50','02cc4152-141f-11ef-9fa4-a4f93399797d');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-22 16:27:23
