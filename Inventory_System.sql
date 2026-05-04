-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: inventory_system
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `Employee_ID` int NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Role` varchar(30) DEFAULT NULL,
  `Phone_No` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Employee_ID`),
  UNIQUE KEY `unique_phone` (`Phone_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'Arjun','Manager','9876543210'),(2,'Sneha','Senior Cashier','9123456780');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_3nf`
--

DROP TABLE IF EXISTS `employee_3nf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_3nf` (
  `Employee_ID` int NOT NULL,
  `Employee_Name` varchar(50) DEFAULT NULL,
  `Employee_Phone` varchar(15) DEFAULT NULL,
  `Role` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Employee_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_3nf`
--

LOCK TABLES `employee_3nf` WRITE;
/*!40000 ALTER TABLE `employee_3nf` DISABLE KEYS */;
INSERT INTO `employee_3nf` VALUES (1,'Arjun','9876543210','Manager'),(2,'Sneha','9123456780','Cashier');
/*!40000 ALTER TABLE `employee_3nf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_regions`
--

DROP TABLE IF EXISTS `employee_regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_regions` (
  `Employee_ID` int NOT NULL,
  `Region` varchar(50) NOT NULL,
  PRIMARY KEY (`Employee_ID`,`Region`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_regions`
--

LOCK TABLES `employee_regions` WRITE;
/*!40000 ALTER TABLE `employee_regions` DISABLE KEYS */;
INSERT INTO `employee_regions` VALUES (1,'North Zone'),(1,'South Zone'),(2,'Central Zone');
/*!40000 ALTER TABLE `employee_regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee_skills`
--

DROP TABLE IF EXISTS `employee_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee_skills` (
  `Employee_ID` int NOT NULL,
  `Skill` varchar(50) NOT NULL,
  PRIMARY KEY (`Employee_ID`,`Skill`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee_skills`
--

LOCK TABLES `employee_skills` WRITE;
/*!40000 ALTER TABLE `employee_skills` DISABLE KEYS */;
INSERT INTO `employee_skills` VALUES (1,'Customer Service'),(1,'Inventory Management'),(2,'Billing');
/*!40000 ALTER TABLE `employee_skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_log`
--

DROP TABLE IF EXISTS `inventory_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_log` (
  `Log_ID` int NOT NULL,
  `Product_ID` int DEFAULT NULL,
  `Employee_ID` int DEFAULT NULL,
  `Quantity_Adjusted` int DEFAULT NULL,
  `Change_Type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Log_ID`),
  KEY `Product_ID` (`Product_ID`),
  KEY `Employee_ID` (`Employee_ID`),
  CONSTRAINT `inventory_log_ibfk_1` FOREIGN KEY (`Product_ID`) REFERENCES `product` (`Product_ID`),
  CONSTRAINT `inventory_log_ibfk_2` FOREIGN KEY (`Employee_ID`) REFERENCES `employee` (`Employee_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_log`
--

LOCK TABLES `inventory_log` WRITE;
/*!40000 ALTER TABLE `inventory_log` DISABLE KEYS */;
INSERT INTO `inventory_log` VALUES (501,101,1,10,'Stock In'),(502,102,1,20,'Stock In'),(503,101,2,-2,'Sold'),(504,103,1,10,'Stock In'),(505,101,2,-1,'Adjustment'),(999,101,NULL,49,'Updated');
/*!40000 ALTER TABLE `inventory_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_log_3nf`
--

DROP TABLE IF EXISTS `inventory_log_3nf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_log_3nf` (
  `Log_ID` int NOT NULL,
  `Change_Type` varchar(20) DEFAULT NULL,
  `Quantity_Adjusted` int DEFAULT NULL,
  `Employee_ID` int DEFAULT NULL,
  `Product_ID` int DEFAULT NULL,
  PRIMARY KEY (`Log_ID`),
  KEY `Employee_ID` (`Employee_ID`),
  KEY `Product_ID` (`Product_ID`),
  CONSTRAINT `inventory_log_3nf_ibfk_1` FOREIGN KEY (`Employee_ID`) REFERENCES `employee_3nf` (`Employee_ID`),
  CONSTRAINT `inventory_log_3nf_ibfk_2` FOREIGN KEY (`Product_ID`) REFERENCES `product_3nf` (`Product_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_log_3nf`
--

LOCK TABLES `inventory_log_3nf` WRITE;
/*!40000 ALTER TABLE `inventory_log_3nf` DISABLE KEYS */;
INSERT INTO `inventory_log_3nf` VALUES (501,'Stock In',10,1,101),(502,'Stock In',20,1,102),(503,'Sold',-2,2,101);
/*!40000 ALTER TABLE `inventory_log_3nf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `Product_ID` int NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Stock_Quantity` int DEFAULT NULL,
  PRIMARY KEY (`Product_ID`),
  CONSTRAINT `chk_price` CHECK ((`Price` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (101,'Keyboard',750.00,49),(102,'Mouse',400.00,80),(103,'Monitor',12000.00,20),(104,'Printer',5000.00,10);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_2nf`
--

DROP TABLE IF EXISTS `product_2nf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_2nf` (
  `Product_Name` varchar(50) NOT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Product_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_2nf`
--

LOCK TABLES `product_2nf` WRITE;
/*!40000 ALTER TABLE `product_2nf` DISABLE KEYS */;
INSERT INTO `product_2nf` VALUES ('Keyboard',750.00),('Monitor',12000.00),('Mouse',400.00);
/*!40000 ALTER TABLE `product_2nf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_3nf`
--

DROP TABLE IF EXISTS `product_3nf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_3nf` (
  `Product_ID` int NOT NULL,
  `Product_Name` varchar(50) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Stock_Quantity` int DEFAULT NULL,
  PRIMARY KEY (`Product_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_3nf`
--

LOCK TABLES `product_3nf` WRITE;
/*!40000 ALTER TABLE `product_3nf` DISABLE KEYS */;
INSERT INTO `product_3nf` VALUES (101,'Keyboard',750.00,50),(102,'Mouse',400.00,80),(103,'Monitor',12000.00,20);
/*!40000 ALTER TABLE `product_3nf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_store`
--

DROP TABLE IF EXISTS `product_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_store` (
  `Product_ID` varchar(10) NOT NULL,
  `Store_ID` varchar(10) NOT NULL,
  PRIMARY KEY (`Product_ID`,`Store_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_store`
--

LOCK TABLES `product_store` WRITE;
/*!40000 ALTER TABLE `product_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_store_5nf`
--

DROP TABLE IF EXISTS `product_store_5nf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_store_5nf` (
  `Product_ID` varchar(10) NOT NULL,
  `Store_ID` varchar(10) NOT NULL,
  PRIMARY KEY (`Product_ID`,`Store_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_store_5nf`
--

LOCK TABLES `product_store_5nf` WRITE;
/*!40000 ALTER TABLE `product_store_5nf` DISABLE KEYS */;
INSERT INTO `product_store_5nf` VALUES ('P1','ST1'),('P2','ST1'),('P2','ST2');
/*!40000 ALTER TABLE `product_store_5nf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `product_view`
--

DROP TABLE IF EXISTS `product_view`;
/*!50001 DROP VIEW IF EXISTS `product_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `product_view` AS SELECT 
 1 AS `Name`,
 1 AS `Price`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `sales_view`
--

DROP TABLE IF EXISTS `sales_view`;
/*!50001 DROP VIEW IF EXISTS `sales_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `sales_view` AS SELECT 
 1 AS `Name`,
 1 AS `Quantity`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sold`
--

DROP TABLE IF EXISTS `sold`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sold` (
  `Transaction_ID` int NOT NULL,
  `Product_ID` int NOT NULL,
  `Quantity` int DEFAULT NULL,
  PRIMARY KEY (`Transaction_ID`,`Product_ID`),
  KEY `Product_ID` (`Product_ID`),
  CONSTRAINT `sold_ibfk_1` FOREIGN KEY (`Transaction_ID`) REFERENCES `transaction` (`Transaction_ID`),
  CONSTRAINT `sold_ibfk_2` FOREIGN KEY (`Product_ID`) REFERENCES `product` (`Product_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sold`
--

LOCK TABLES `sold` WRITE;
/*!40000 ALTER TABLE `sold` DISABLE KEYS */;
INSERT INTO `sold` VALUES (1001,101,1),(1001,102,1),(1002,103,1);
/*!40000 ALTER TABLE `sold` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_product`
--

DROP TABLE IF EXISTS `supplier_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier_product` (
  `Supplier_ID` varchar(10) NOT NULL,
  `Product_ID` varchar(10) NOT NULL,
  PRIMARY KEY (`Supplier_ID`,`Product_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_product`
--

LOCK TABLES `supplier_product` WRITE;
/*!40000 ALTER TABLE `supplier_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `supplier_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_product_5nf`
--

DROP TABLE IF EXISTS `supplier_product_5nf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier_product_5nf` (
  `Supplier_ID` varchar(10) NOT NULL,
  `Product_ID` varchar(10) NOT NULL,
  PRIMARY KEY (`Supplier_ID`,`Product_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_product_5nf`
--

LOCK TABLES `supplier_product_5nf` WRITE;
/*!40000 ALTER TABLE `supplier_product_5nf` DISABLE KEYS */;
INSERT INTO `supplier_product_5nf` VALUES ('S1','P1'),('S1','P2'),('S2','P1'),('S2','P2');
/*!40000 ALTER TABLE `supplier_product_5nf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_store`
--

DROP TABLE IF EXISTS `supplier_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier_store` (
  `Supplier_ID` varchar(10) NOT NULL,
  `Store_ID` varchar(10) NOT NULL,
  PRIMARY KEY (`Supplier_ID`,`Store_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_store`
--

LOCK TABLES `supplier_store` WRITE;
/*!40000 ALTER TABLE `supplier_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `supplier_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier_store_5nf`
--

DROP TABLE IF EXISTS `supplier_store_5nf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier_store_5nf` (
  `Supplier_ID` varchar(10) NOT NULL,
  `Store_ID` varchar(10) NOT NULL,
  PRIMARY KEY (`Supplier_ID`,`Store_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier_store_5nf`
--

LOCK TABLES `supplier_store_5nf` WRITE;
/*!40000 ALTER TABLE `supplier_store_5nf` DISABLE KEYS */;
INSERT INTO `supplier_store_5nf` VALUES ('S1','ST1'),('S2','ST1'),('S2','ST2');
/*!40000 ALTER TABLE `supplier_store_5nf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction` (
  `Transaction_ID` int NOT NULL,
  `Date` date DEFAULT NULL,
  `Time` time DEFAULT NULL,
  `Total_Amount` decimal(10,2) DEFAULT NULL,
  `Employee_ID` int DEFAULT NULL,
  PRIMARY KEY (`Transaction_ID`),
  KEY `Employee_ID` (`Employee_ID`),
  CONSTRAINT `transaction_ibfk_1` FOREIGN KEY (`Employee_ID`) REFERENCES `employee` (`Employee_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1001,'2026-02-10','10:30:00',1150.00,2),(1002,'2026-02-10','11:00:00',12000.00,1),(1003,'2026-04-10','09:15:00',1550.00,2);
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_1nf`
--

DROP TABLE IF EXISTS `transaction_1nf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_1nf` (
  `Transaction_ID` int DEFAULT NULL,
  `Employee_Name` varchar(50) DEFAULT NULL,
  `Employee_Phone` varchar(15) DEFAULT NULL,
  `Product_Name` varchar(50) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `Qty` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_1nf`
--

LOCK TABLES `transaction_1nf` WRITE;
/*!40000 ALTER TABLE `transaction_1nf` DISABLE KEYS */;
INSERT INTO `transaction_1nf` VALUES (1001,'Sneha','9123456780','Keyboard',750.00,2),(1001,'Sneha','9123456780','Mouse',400.00,1),(1002,'Arjun','9876543210','Monitor',12000.00,1);
/*!40000 ALTER TABLE `transaction_1nf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_2nf`
--

DROP TABLE IF EXISTS `transaction_2nf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_2nf` (
  `Transaction_ID` int NOT NULL,
  `Employee_Name` varchar(50) DEFAULT NULL,
  `Employee_Phone` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Transaction_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_2nf`
--

LOCK TABLES `transaction_2nf` WRITE;
/*!40000 ALTER TABLE `transaction_2nf` DISABLE KEYS */;
INSERT INTO `transaction_2nf` VALUES (1001,'Sneha','9123456780'),(1002,'Arjun','9876543210');
/*!40000 ALTER TABLE `transaction_2nf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_3nf`
--

DROP TABLE IF EXISTS `transaction_3nf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_3nf` (
  `Transaction_ID` int NOT NULL,
  `Date` date DEFAULT NULL,
  `Time` time DEFAULT NULL,
  `Total_Amount` decimal(10,2) DEFAULT NULL,
  `Employee_ID` int DEFAULT NULL,
  PRIMARY KEY (`Transaction_ID`),
  KEY `Employee_ID` (`Employee_ID`),
  CONSTRAINT `transaction_3nf_ibfk_1` FOREIGN KEY (`Employee_ID`) REFERENCES `employee_3nf` (`Employee_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_3nf`
--

LOCK TABLES `transaction_3nf` WRITE;
/*!40000 ALTER TABLE `transaction_3nf` DISABLE KEYS */;
INSERT INTO `transaction_3nf` VALUES (1001,'2026-02-10','10:30:00',1150.00,2),(1002,'2026-02-10','11:00:00',12000.00,1);
/*!40000 ALTER TABLE `transaction_3nf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_item`
--

DROP TABLE IF EXISTS `transaction_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_item` (
  `Transaction_Item_ID` int NOT NULL AUTO_INCREMENT,
  `Transaction_ID` int NOT NULL,
  `Product_ID` int NOT NULL,
  `Quantity` int NOT NULL,
  `Unit_Price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`Transaction_Item_ID`),
  KEY `Transaction_ID` (`Transaction_ID`),
  KEY `Product_ID` (`Product_ID`),
  CONSTRAINT `fk_ti_product` FOREIGN KEY (`Product_ID`) REFERENCES `product` (`Product_ID`),
  CONSTRAINT `fk_ti_transaction` FOREIGN KEY (`Transaction_ID`) REFERENCES `transaction` (`Transaction_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_item`
--

LOCK TABLES `transaction_item` WRITE;
/*!40000 ALTER TABLE `transaction_item` DISABLE KEYS */;
INSERT INTO `transaction_item` VALUES (4,1003,101,1,750.00),(5,1003,102,1,400.00);
/*!40000 ALTER TABLE `transaction_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_item_2nf`
--

DROP TABLE IF EXISTS `transaction_item_2nf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_item_2nf` (
  `Transaction_ID` int NOT NULL,
  `Product_Name` varchar(50) NOT NULL,
  `Quantity` int DEFAULT NULL,
  PRIMARY KEY (`Transaction_ID`,`Product_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_item_2nf`
--

LOCK TABLES `transaction_item_2nf` WRITE;
/*!40000 ALTER TABLE `transaction_item_2nf` DISABLE KEYS */;
INSERT INTO `transaction_item_2nf` VALUES (1001,'Keyboard',2),(1001,'Mouse',1),(1002,'Monitor',1);
/*!40000 ALTER TABLE `transaction_item_2nf` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unnormalized_table`
--

DROP TABLE IF EXISTS `unnormalized_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unnormalized_table` (
  `Transaction_ID` int DEFAULT NULL,
  `Employee_Name` varchar(50) DEFAULT NULL,
  `Employee_Phone` varchar(15) DEFAULT NULL,
  `Product_Name` varchar(100) DEFAULT NULL,
  `Price` varchar(50) DEFAULT NULL,
  `Qty` varchar(50) DEFAULT NULL,
  `Change_Type` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unnormalized_table`
--

LOCK TABLES `unnormalized_table` WRITE;
/*!40000 ALTER TABLE `unnormalized_table` DISABLE KEYS */;
INSERT INTO `unnormalized_table` VALUES (1001,'Sneha','9123456780','Keyboard, Mouse','750, 400','2, 1','Sold'),(1002,'Arjun','9876543210','Monitor','12000','1','Sold'),(1003,'Sneha','9123456780','Keyboard','750','5','Stock In');
/*!40000 ALTER TABLE `unnormalized_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `role` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `product_view`
--

/*!50001 DROP VIEW IF EXISTS `product_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `product_view` AS select `product`.`Name` AS `Name`,`product`.`Price` AS `Price` from `product` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sales_view`
--

/*!50001 DROP VIEW IF EXISTS `sales_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `sales_view` AS select `p`.`Name` AS `Name`,`s`.`Quantity` AS `Quantity` from (`product` `p` join `sold` `s` on((`p`.`Product_ID` = `s`.`Product_ID`))) */;
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

-- Dump completed on 2026-05-03 15:00:22
