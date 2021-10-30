-- MySQL dump 10.13  Distrib 8.0.26, for Win64 (x86_64)
--
-- Host: localhost    Database: parking_system
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `devices`
--

DROP TABLE IF EXISTS `devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `devices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `id_type_device` bigint unsigned NOT NULL,
  `number_device` bigint unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `number_device` (`number_device`),
  KEY `id_type_device` (`id_type_device`),
  CONSTRAINT `devices_ibfk_1` FOREIGN KEY (`id_type_device`) REFERENCES `type_devices` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices`
--

LOCK TABLES `devices` WRITE;
/*!40000 ALTER TABLE `devices` DISABLE KEYS */;
INSERT INTO `devices` VALUES (1,1,101,'2021-10-21 11:03:58'),(2,1,102,'2021-10-21 11:03:58'),(3,1,103,'2021-10-21 11:03:58'),(4,1,104,'2021-10-21 11:03:58'),(5,1,105,'2021-10-21 11:03:58'),(6,2,201,'2021-10-21 11:03:58'),(7,2,202,'2021-10-21 11:03:58'),(8,2,203,'2021-10-21 11:03:58'),(9,2,204,'2021-10-21 11:03:58'),(10,3,601,'2021-10-21 11:03:58'),(11,3,602,'2021-10-21 11:03:58'),(12,3,603,'2021-10-21 11:03:58'),(13,3,604,'2021-10-21 11:03:58'),(14,3,605,'2021-10-21 11:03:58'),(15,3,606,'2021-10-21 11:03:58'),(16,4,701,'2021-10-21 11:03:58'),(17,5,801,'2021-10-21 11:03:58'),(18,5,802,'2021-10-21 11:03:58');
/*!40000 ALTER TABLE `devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entry_parking_transactions`
--

DROP TABLE IF EXISTS `entry_parking_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entry_parking_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `entry_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `card_type` varchar(30) DEFAULT NULL,
  `client_card_id` bigint unsigned DEFAULT NULL,
  `zone_id` bigint unsigned NOT NULL,
  `device_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client_card_id` (`client_card_id`),
  KEY `zone_id` (`zone_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `entry_parking_transactions_ibfk_1` FOREIGN KEY (`client_card_id`) REFERENCES `season_card_payments` (`id`),
  CONSTRAINT `entry_parking_transactions_ibfk_2` FOREIGN KEY (`zone_id`) REFERENCES `parking_zone` (`id`),
  CONSTRAINT `entry_parking_transactions_ibfk_3` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`),
  CONSTRAINT `card_type` CHECK (((`card_type` = _utf8mb4'parking ticket') or (`card_type` = _utf8mb4'season card')))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entry_parking_transactions`
--

LOCK TABLES `entry_parking_transactions` WRITE;
/*!40000 ALTER TABLE `entry_parking_transactions` DISABLE KEYS */;
INSERT INTO `entry_parking_transactions` VALUES (1,'2021-10-15 09:10:04','parking ticket',NULL,2,1),(2,'2021-10-15 09:40:04','parking ticket',NULL,2,3),(3,'2021-10-15 09:55:04','parking ticket',NULL,3,5),(4,'2021-10-15 10:25:04','parking ticket',NULL,3,5),(5,'2021-10-15 10:35:04','season card',1,2,2),(6,'2021-10-15 10:35:04','season card',2,3,5);
/*!40000 ALTER TABLE `entry_parking_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exit_parking_transactions`
--

DROP TABLE IF EXISTS `exit_parking_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exit_parking_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `exit_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `device_id` bigint unsigned NOT NULL,
  `entry_info_id` bigint unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `entry_info_id` (`entry_info_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `exit_parking_transactions_ibfk_1` FOREIGN KEY (`entry_info_id`) REFERENCES `entry_parking_transactions` (`id`),
  CONSTRAINT `exit_parking_transactions_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`),
  CONSTRAINT `exit_parking_transactions_ibfk_3` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exit_parking_transactions`
--

LOCK TABLES `exit_parking_transactions` WRITE;
/*!40000 ALTER TABLE `exit_parking_transactions` DISABLE KEYS */;
INSERT INTO `exit_parking_transactions` VALUES (1,'2021-10-15 18:10:04',7,1),(2,'2021-10-15 18:30:04',8,2),(3,'2021-10-15 18:40:04',9,3),(4,'2021-10-15 18:45:04',9,4),(5,'2021-10-15 18:48:04',7,5),(6,'2021-10-15 18:50:04',9,6);
/*!40000 ALTER TABLE `exit_parking_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `open_barrier`
--

DROP TABLE IF EXISTS `open_barrier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `open_barrier` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `device_id` bigint unsigned NOT NULL,
  `time_to_open` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `device_id` (`device_id`),
  CONSTRAINT `open_barrier_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `system_users` (`id`),
  CONSTRAINT `open_barrier_ibfk_2` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `open_barrier`
--

LOCK TABLES `open_barrier` WRITE;
/*!40000 ALTER TABLE `open_barrier` DISABLE KEYS */;
INSERT INTO `open_barrier` VALUES (1,2,6,'2021-10-21 11:03:58'),(2,3,9,'2021-10-21 11:03:58'),(3,4,5,'2021-10-21 11:03:58'),(4,5,1,'2021-10-21 11:03:58'),(5,3,4,'2021-10-21 11:03:58'),(6,6,2,'2021-10-21 11:03:58'),(7,5,3,'2021-10-21 11:03:58'),(8,3,8,'2021-10-21 11:03:58'),(9,2,3,'2021-10-21 11:03:58'),(10,4,6,'2021-10-21 11:03:58');
/*!40000 ALTER TABLE `open_barrier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parking_ticket_payments`
--

DROP TABLE IF EXISTS `parking_ticket_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parking_ticket_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `payment_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `tariff_id` bigint unsigned NOT NULL,
  `parking_time` varchar(30) DEFAULT NULL,
  `client_payment` bigint unsigned NOT NULL,
  `id_type_payment` bigint unsigned NOT NULL,
  `device_id` bigint unsigned NOT NULL,
  `sales_id` bigint unsigned DEFAULT NULL,
  `entry_id` bigint unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `entry_id` (`entry_id`),
  KEY `tariff_id` (`tariff_id`),
  KEY `id_type_payment` (`id_type_payment`),
  KEY `device_id` (`device_id`),
  KEY `sales_id` (`sales_id`),
  CONSTRAINT `parking_ticket_payments_ibfk_1` FOREIGN KEY (`entry_id`) REFERENCES `entry_parking_transactions` (`id`),
  CONSTRAINT `parking_ticket_payments_ibfk_2` FOREIGN KEY (`id`) REFERENCES `entry_parking_transactions` (`id`),
  CONSTRAINT `parking_ticket_payments_ibfk_3` FOREIGN KEY (`tariff_id`) REFERENCES `tariffs` (`id`),
  CONSTRAINT `parking_ticket_payments_ibfk_4` FOREIGN KEY (`id_type_payment`) REFERENCES `type_payment` (`id`),
  CONSTRAINT `parking_ticket_payments_ibfk_5` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`),
  CONSTRAINT `parking_ticket_payments_ibfk_6` FOREIGN KEY (`sales_id`) REFERENCES `sales` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parking_ticket_payments`
--

LOCK TABLES `parking_ticket_payments` WRITE;
/*!40000 ALTER TABLE `parking_ticket_payments` DISABLE KEYS */;
INSERT INTO `parking_ticket_payments` VALUES (1,'2021-10-15 18:00:04',2,'~ 9 часов',700,2,10,NULL,1),(2,'2021-10-15 18:20:04',2,'~ 9 часов',700,1,12,NULL,2),(3,'2021-10-15 18:25:04',4,'~ 9 часов',1400,2,14,NULL,3),(4,'2021-10-15 18:30:04',4,'~ 9 часов',1400,1,15,NULL,4);
/*!40000 ALTER TABLE `parking_ticket_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parking_zone`
--

DROP TABLE IF EXISTS `parking_zone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parking_zone` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `zone_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `zone_name` CHECK (((`zone_name` = _utf8mb4'full parking') or (`zone_name` = _utf8mb4'indoor parking') or (`zone_name` = _utf8mb4'outdoor parking')))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parking_zone`
--

LOCK TABLES `parking_zone` WRITE;
/*!40000 ALTER TABLE `parking_zone` DISABLE KEYS */;
INSERT INTO `parking_zone` VALUES (1,'full parking'),(2,'indoor parking'),(3,'outdoor parking');
/*!40000 ALTER TABLE `parking_zone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `sales_name` varchar(50) NOT NULL,
  `sales_tariff` varchar(50) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `sales_name` (`sales_name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1,'выходного дня','бесплатные выходные','2021-10-21 11:03:58'),(2,'посетители ашана','бесплатно 2 часа','2021-10-21 11:03:58'),(3,'посетители мойки','бесплатно 3 часа','2021-10-21 11:03:58'),(4,'посетители фитнеса','бесплатно 5 часов','2021-10-21 11:03:58'),(5,'посетители кинотеатра','скидка 50%','2021-10-21 11:03:58');
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `season_card_payments`
--

DROP TABLE IF EXISTS `season_card_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `season_card_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `payment_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `client_payment` bigint unsigned NOT NULL,
  `contract_number` varchar(30) NOT NULL,
  `client_card` varchar(30) NOT NULL,
  `type_client` varchar(20) DEFAULT NULL,
  `client_company_name` varchar(50) DEFAULT NULL,
  `client_full_name` varchar(100) NOT NULL,
  `client_number_avto` varchar(100) DEFAULT NULL,
  `tariff_id` bigint unsigned NOT NULL,
  `time_start_contract` datetime DEFAULT NULL,
  `time_end_contract` datetime DEFAULT NULL,
  `id_type_payment` bigint unsigned NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  UNIQUE KEY `id` (`id`),
  KEY `tariff_id` (`tariff_id`),
  KEY `id_type_payment` (`id_type_payment`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `season_card_payments_ibfk_1` FOREIGN KEY (`tariff_id`) REFERENCES `tariffs` (`id`),
  CONSTRAINT `season_card_payments_ibfk_2` FOREIGN KEY (`id_type_payment`) REFERENCES `type_payment` (`id`),
  CONSTRAINT `season_card_payments_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `system_users` (`id`),
  CONSTRAINT `type_client` CHECK (((`type_client` = _utf8mb4'company') or (`type_client` = _utf8mb4'human')))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `season_card_payments`
--

LOCK TABLES `season_card_payments` WRITE;
/*!40000 ALTER TABLE `season_card_payments` DISABLE KEYS */;
INSERT INTO `season_card_payments` VALUES (1,'2021-09-25 17:10:04',7500,'№123А27ОТ','a4536bfe','company','ООО Ромашка','Иванов Иван','T234TT777',6,'2021-09-25 17:10:04','2021-10-25 17:10:04',2,5),(2,'2021-09-10 09:10:04',10000,'№47А2АВ22','a5566bac','human',NULL,'Петр Сковоодкин','А654МР777',5,'2021-09-10 09:10:04','2021-11-10 09:10:04',1,6);
/*!40000 ALTER TABLE `season_card_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_errors`
--

DROP TABLE IF EXISTS `system_errors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_errors` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `device_id` bigint unsigned NOT NULL,
  `type_errors` varchar(150) NOT NULL,
  `time_error` datetime DEFAULT CURRENT_TIMESTAMP,
  `time_troubleshooting` datetime DEFAULT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_id` (`device_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `system_errors_ibfk_1` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`),
  CONSTRAINT `system_errors_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `system_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_errors`
--

LOCK TABLES `system_errors` WRITE;
/*!40000 ALTER TABLE `system_errors` DISABLE KEYS */;
INSERT INTO `system_errors` VALUES (1,1,'поломка стрелы шлагбаума','2021-10-10 17:10:04','2021-10-10 19:52:04',2),(2,12,'замятие фискальной ленты','2021-10-11 13:30:04','2021-10-11 13:52:04',5),(3,15,'ошибка банковской оплаты','2021-10-11 23:30:04','2021-10-11 23:40:04',5),(4,6,'застрял парковочный билет','2021-10-12 10:10:04','2021-10-12 10:23:04',3),(5,3,'сбой питания 220 вольт','2021-10-14 21:30:04','2021-10-14 22:45:04',4);
/*!40000 ALTER TABLE `system_errors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_users`
--

DROP TABLE IF EXISTS `system_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `system_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type_user` varchar(50) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `telephone_number` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `full_name` (`full_name`),
  UNIQUE KEY `telephone_number` (`telephone_number`),
  CONSTRAINT `type_user` CHECK (((`type_user` = _utf8mb4'technic') or (`type_user` = _utf8mb4'system admin') or (`type_user` = _utf8mb4'chaiser')))
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_users`
--

LOCK TABLES `system_users` WRITE;
/*!40000 ALTER TABLE `system_users` DISABLE KEYS */;
INSERT INTO `system_users` VALUES (1,'system admin','Иванов Иван Иванович','8-999-999-99-99','2021-10-21 11:03:58'),(2,'technic','Петров Петр Петрович','8-991-999-99-99','2021-10-21 11:03:58'),(3,'technic','Сидоров Петр Иванович','8-991-955-95-59','2021-10-21 11:03:58'),(4,'technic','Смирнов Фёдор Иванович','8-921-925-25-29','2021-10-21 11:03:58'),(5,'chaiser','Карпова Наталья Петровна','8-991-355-35-53','2021-10-21 11:03:58'),(6,'chaiser','Романова Елена Фёдоровина','8-991-235-45-49','2021-10-21 11:03:58');
/*!40000 ALTER TABLE `system_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tariffs`
--

DROP TABLE IF EXISTS `tariffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tariffs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tariff_name` varchar(50) NOT NULL,
  `tariff_price_ticket` varchar(50) DEFAULT NULL,
  `tariff_price_season_card` varchar(50) DEFAULT NULL,
  `id_parking_zone` bigint unsigned NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_parking_zone` (`id_parking_zone`),
  CONSTRAINT `tariffs_ibfk_1` FOREIGN KEY (`id_parking_zone`) REFERENCES `parking_zone` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tariffs`
--

LOCK TABLES `tariffs` WRITE;
/*!40000 ALTER TABLE `tariffs` DISABLE KEYS */;
INSERT INTO `tariffs` VALUES (1,'бесплатный','бесплатно',NULL,1,'2021-10-21 11:03:58'),(2,'тариф буднего дня','2 часа бесплатно далее 100руб час',NULL,2,'2021-10-21 11:03:58'),(3,'тариф выходного дня','20 мин бесплатно далее 100руб час',NULL,2,'2021-10-21 11:03:58'),(4,'тариф ВИП','5 мин бесплатно далее 200руб час',NULL,3,'2021-10-21 11:03:58'),(5,'физ лица',NULL,'5000руб месяц',2,'2021-10-21 11:03:58'),(6,'юр лица',NULL,'7500руб месяц',2,'2021-10-21 11:03:58'),(7,'служба эксплуатации',NULL,'бесплатно',3,'2021-10-21 11:03:58');
/*!40000 ALTER TABLE `tariffs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_devices`
--

DROP TABLE IF EXISTS `type_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_devices` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type_devices` varchar(50) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `type_devices` (`type_devices`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_devices`
--

LOCK TABLES `type_devices` WRITE;
/*!40000 ALTER TABLE `type_devices` DISABLE KEYS */;
INSERT INTO `type_devices` VALUES (1,'entry','2021-10-21 11:03:57'),(2,'exit','2021-10-21 11:03:57'),(3,'payment_terminal','2021-10-21 11:03:57'),(4,'server PC','2021-10-21 11:03:57'),(5,'client PC','2021-10-21 11:03:58');
/*!40000 ALTER TABLE `type_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_payment`
--

DROP TABLE IF EXISTS `type_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `type_payment` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name_payment` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_payment` (`name_payment`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_payment`
--

LOCK TABLES `type_payment` WRITE;
/*!40000 ALTER TABLE `type_payment` DISABLE KEYS */;
INSERT INTO `type_payment` VALUES (2,'bank card'),(1,'cash'),(3,'payment by invoice'),(4,'payment in the app');
/*!40000 ALTER TABLE `type_payment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-21 11:09:04
