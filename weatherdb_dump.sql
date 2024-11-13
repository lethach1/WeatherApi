-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: weatherdb
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locations` (
  `code` varchar(12) NOT NULL,
  `city_name` varchar(128) NOT NULL,
  `country_code` varchar(2) NOT NULL,
  `country_name` varchar(64) NOT NULL,
  `enabled` bit(1) NOT NULL,
  `region_name` varchar(128) DEFAULT NULL,
  `trashed` bit(1) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES ('BJG_CN','Beijing','CN','China',_binary '\0',NULL,_binary '\0'),('BLHWH_USA','Bellingham','US','United States of America',_binary '','Washington',_binary '\0'),('BLVWH_USA','Bellevue','US','United States of America',_binary '','Washington',_binary '\0'),('BNGK_TL','Bangkok','TL','Thailand',_binary '','Central of Thailand',_binary '\0'),('DELHI_IN','DELHI','IN','India',_binary '','DELHI',_binary '\0'),('LACA_US','Los Angeles','US','United States of America',_binary '','California',_binary '\0'),('MBM_IN','Mumbai','IN','India',_binary '','Maharashtra',_binary '\0'),('NYC_US','New York','US','New York City',_binary '','New York',_binary '\0');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `realtime_weather`
--

DROP TABLE IF EXISTS `realtime_weather`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `realtime_weather` (
  `location_code` varchar(12) NOT NULL,
  `humidity` int NOT NULL,
  `last_updated` datetime(6) DEFAULT NULL,
  `precipitation` int NOT NULL,
  `status` varchar(50) NOT NULL,
  `temperature` int NOT NULL,
  `wind_speed` int NOT NULL,
  PRIMARY KEY (`location_code`),
  CONSTRAINT `FKgvl48yx0pq95h8xw589p0mxui` FOREIGN KEY (`location_code`) REFERENCES `locations` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `realtime_weather`
--

LOCK TABLES `realtime_weather` WRITE;
/*!40000 ALTER TABLE `realtime_weather` DISABLE KEYS */;
INSERT INTO `realtime_weather` VALUES ('DELHI_IN',60,'2024-10-23 17:15:18.666000',70,'Sunny',10,10),('NYC_USA',55,'2024-11-13 13:24:22.290000',23,'Cloudy',12,8);
/*!40000 ALTER TABLE `realtime_weather` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weather_daily`
--

DROP TABLE IF EXISTS `weather_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weather_daily` (
  `day_of_month` int NOT NULL,
  `month` int NOT NULL,
  `max_temp` int NOT NULL,
  `min_temp` int NOT NULL,
  `precipitation` int NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `location_code` varchar(12) NOT NULL,
  PRIMARY KEY (`day_of_month`,`location_code`,`month`),
  KEY `FKdb65slqm144d0ol3mhl1wglwh` (`location_code`),
  CONSTRAINT `FKdb65slqm144d0ol3mhl1wglwh` FOREIGN KEY (`location_code`) REFERENCES `locations` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weather_daily`
--

LOCK TABLES `weather_daily` WRITE;
/*!40000 ALTER TABLE `weather_daily` DISABLE KEYS */;
INSERT INTO `weather_daily` VALUES (10,2,12,6,60,'Cloudy','DELHI_IN'),(10,2,12,6,60,'Cloudy','NYC_US'),(11,2,14,7,70,'Sunny','DELHI_IN'),(11,2,14,7,70,'Sunny','NYC_US'),(12,2,10,6,90,'Rainy','DELHI_IN'),(12,2,10,6,90,'Rainy','NYC_US');
/*!40000 ALTER TABLE `weather_daily` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weather_hourly`
--

DROP TABLE IF EXISTS `weather_hourly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weather_hourly` (
  `hour_of_day` int NOT NULL,
  `precipitation` int NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `temperature` int NOT NULL,
  `location_code` varchar(12) NOT NULL,
  PRIMARY KEY (`hour_of_day`,`location_code`),
  KEY `FKb9fne1kfqb2pp4ahjft9an5q9` (`location_code`),
  CONSTRAINT `FKb9fne1kfqb2pp4ahjft9an5q9` FOREIGN KEY (`location_code`) REFERENCES `locations` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weather_hourly`
--

LOCK TABLES `weather_hourly` WRITE;
/*!40000 ALTER TABLE `weather_hourly` DISABLE KEYS */;
INSERT INTO `weather_hourly` VALUES (1,43,'Rainy',17,'NYC_US'),(2,23,'Rainy',18,'NYC_US'),(3,64,'Rainy',16,'NYC_US'),(4,54,'Groomy',17,'NYC_US'),(5,34,'Groomy',15,'NYC_US'),(6,76,'Sunny',14,'NYC_US'),(7,32,'Sunny',13,'NYC_US'),(8,88,'Cloudy',12,'NYC_US'),(9,86,'Cloudy',13,'NYC_US'),(10,40,'Sunny',15,'DELHI_IN'),(10,60,'Sunny',15,'NYC_US'),(11,50,'Cloudy',16,'DELHI_IN'),(12,52,'Cloudy',13,'NYC_US');
/*!40000 ALTER TABLE `weather_hourly` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-13 17:30:20
